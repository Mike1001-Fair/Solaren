<% //@ LANGUAGE = "JScript"
var User = {
	Role   : ["Адмiнiстратор","Виконавець","Технік ЦОС"],
	LoginRe: /(?=.*[a-z])(?=.*[A-Z]).{8,10}/,
	PswdRe : /(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{10}/,
	PswdLen: 10,
	GuidRe : /^[{]?[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}[}]?$/,
	Ip     : Request.ServerVariables("REMOTE_ADDR") || -1,
	Agent  : Request.ServerVariables("HTTP_USER_AGENT") || -1,
	Method : Request.ServerVariables("REQUEST_METHOD") || -1,
	Hal    : String(Request.ServerVariables("HTTP_ACCEPT_LANGUAGE")) || -1,
	Id     : Session("UserId") || -1,
	GUID   : Session("UserGUID") || -1,
	RoleId : Session("RoleId") || -1,
	Token  : Session("Token") || -1,

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

	ValidateRole: function(RoleId, UserGUID) {
		//Response.Write("<BR>Authenticate: RoleId=" + RoleId + "<BR>UserGUID=" + User.GUID + "<BR>Token=" + User.Token);
		return RoleId == this.RoleId && this.Role[RoleId] && this.GuidRe.test(UserGUID) 
	},

	Authorize: function(RoleId) {
		var Done  = false,
		ValidRole = this.ValidateRole(RoleId, this.GUID);

		if (ValidRole) {
			try {
				Solaren.SetCmd("UserAuthorize");
				with (Cmd) {
					with (Parameters) {
						Append(CreateParameter("SessionId", adInteger, adParamInput, 10, Session.SessionID));
						Append(CreateParameter("UserId", adInteger, adParamInput, 10, this.Id));
						Append(CreateParameter("RoleId", adTinyInt, adParamInput, 10, RoleId));
						Append(CreateParameter("UserIp", adVarChar, adParamInput, 15, this.Ip));
						Append(CreateParameter("UserGUID", adGUID, adParamInput, 40, this.GUID));
						Append(CreateParameter("Token", adChar, adParamInput, 32, this.Token));
						Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
					} Execute(adExecuteNoRecords);
					Done = Parameters.Item("Done").value;
				}
			} catch (ex) {
				Message.Write(3, Message.Error(ex))
			} finally {
				Solaren.Close();
			}
		}
		//Response.Write("<BR>Authorize: RoleId=" + User.RoleId + "<BR>SessionID=" + Session.SessionID + "<BR>UserGUID=" + User.GUID + "<BR>Token=" + User.Token + "<BR>ValidRole = " + ValidRole);
		return Done;
	},

	GetPswd: function() {
		var maxAttempts = 9,				
		valid = false;
		for (var i = 0; i < maxAttempts && !valid; i++) {
			var Chars = new Array(this.PswdLen);
			for (var j = 0; j < this.PswdLen; j++) {
				Chars[j] = String.fromCharCode(Solaren.GetRandInt(33, 126));
			}
			var Pswd = Chars.join("");
			valid = this.PswdRe.test(Pswd);
		}
		return valid ? Pswd : ""
	},

	ValidateAccess: function(Authorized, method) {
		var validMethod = this.Method == method,
		validAccess = Authorized && validMethod;
		if (!validAccess) {
			Resource.Load(User.ResourceFile());
			Message.Write(2, Dictionary.Item("AuthorizationError"));
		}
		return validAccess
	},

	WriteRole: function(tagName, RoleId) {
		var ResponseText = ['<SELECT NAME="' + tagName + '">'],
		selected, option;
		for (var i = 0; i < this.Role.length; i++) {
			selected = i == RoleId ? '" SELECTED>' : '">';
			option = ['<OPTION VALUE="', i, selected, this.Role[i], '</OPTION>'];
			ResponseText.push(option.join(""));
		}
		ResponseText.push('</SELECT>');
		Response.Write(ResponseText.join("\n"))
	}
}%>