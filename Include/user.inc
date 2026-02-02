<% //@ LANGUAGE = "JScript"
var User = {
	Role   : ["Адмiнiстратор", "Виконавець", "Технік ЦОС"],
	LoginRe: /^[a-zA-Z0-9._-]{8,16}$/,
	PswdRe: /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*]).{16}$/,
	PswdLen: 16,
	GuidRe : /^[{]?[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}[}]?$/,
	Ip     : Request.ServerVariables("REMOTE_ADDR") || "",
	Agent  : Request.ServerVariables("HTTP_USER_AGENT") || "",
	Hal    : String(Request.ServerVariables("HTTP_ACCEPT_LANGUAGE")) || "",
	Id     : Session("UserId"),
	GUID   : Session("UserGUID"),
	RoleId : Session("RoleId"),
	Token  : Session("Token"),

	Language: function() {
		var regionSet = this.Hal.split(",")[0];
		return regionSet.split("-")[0]
	},

	ResourceFile: function() {
		var LanguageSet = "uk",
		UserLanguage = this.Language(),
		LanguageCode = LanguageSet.indexOf(UserLanguage) > -1 ? UserLanguage : "en",	//default to English
		FileName     = ["server-", LanguageCode, ".xml"];
		return FileName.join("")
	},

	ValidateCredentials: function(Form) {
		return this.LoginRe.test(Form.UserName) && this.PswdRe.test(Form.Pswd);
	},

	ValidateRole: function(RoleId) {
		//Db.Write("<BR>Authenticate: RoleId=" + RoleId + "<BR>UserGUID=" + User.GUID + "<BR>Token=" + User.Token);
		return RoleId == this.RoleId && this.Role[RoleId] 
	},

	Authorize: function(RoleId) {
		var Done = 0;
		try {
			Db.SetCmd("UserAuthorize");
			with (Cmd) {
				with (Parameters) {
					Append(CreateParameter("SessionId", adInteger, adParamInput, 10, Session.SessionID));
					Append(CreateParameter("UserId", adInteger, adParamInput, 10, this.Id));
					Append(CreateParameter("RoleId", adTinyInt, adParamInput, 10, RoleId));
					Append(CreateParameter("UserIp", adVarChar, adParamInput, 15, this.Ip));
					Append(CreateParameter("UserGUID", adGUID, adParamInput, 40, this.GUID));
					Append(CreateParameter("Token", adChar, adParamInput, 32, this.Token));
					Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
				}
				Execute(adExecuteNoRecords);
				Done = Parameters.Item("Done").Value; 
			}
		} catch (ex) {
			Message.Write(3, Message.Error(ex))
		} finally {
			Db.DelParameters();
			Db.Close();
		}
		//Db.Write("<BR>Authorize: RoleId=" + User.RoleId + "<BR>SessionID=" + Session.SessionID + "<BR>UserGUID=" + User.GUID + "<BR>Token=" + User.Token);
		return Done;
	},

	CheckAuthorize: function(RoleId) {
		var validParams = this.ValidateRole(RoleId) && this.GuidRe.test(this.GUID);
		if (validParams) {
			if (!this.Authorize(RoleId)) {
				Message.Write(2, Dictionary.Item("AuthorizationError"))
			}
		} else {
			Message.Write(2, Dictionary.Item("AuthenticationError"))
		}
	},

	GetPswd: function() {
		var maxAttempts = 9,
		charCodeMin = 33,
		charCodeMax = 126;
		valid = false;
		for (var i = 0; i < maxAttempts && !valid; i++) {
			var Chars = new Array(this.PswdLen);
			for (var j = 0; j < this.PswdLen; j++) {
				Chars[j] = String.fromCharCode(Webserver.GetRandInt(charCodeMin, charCodeMax));
			}
			var Pswd = Chars.join("");
			valid = this.PswdRe.test(Pswd);
		}
		return valid ? Pswd : ""
	},

	HasAccess: function(Authorized, method) {
		//Response.Write(Application("ServerName") + '<br>' + Db.WebServer);
		return Authorized && Webserver.Method == method && Webserver.Filter(Application("AppName"));
	},

	CheckAccess: function(Authorized, method) {
		var valid = this.HasAccess(Authorized, method);
		if (!valid) {
			Resource.Load(User.ResourceFile());
			Message.Write(2, Dictionary.Item("AuthorizationError"));
		}
		return valid;
	},

	WriteRole: function(tagName, RoleId) {
		var Output = ['<SELECT NAME="' + tagName + '">'];
		for (var i = 0; i < this.Role.length; i++) {
			var selected = i == RoleId,
			option = Html.GetOption(i, selected, this.Role[i]);
			Output.push(option);
		}
		Output.push('</SELECT>');
		Response.Write(Output.join("\n"))
	}
}%>