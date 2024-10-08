﻿<% //@ LANGUAGE = "JScript"
var User = {
	Role   : ["Адмiнiстратор","Виконавець","Технік ЦОС"],
	PswdLen: 10,
	PswdRe : /(?=.*\d)(?=.*[a-z])(?=.*[A-Z])/,
	GuidRe : /^[{]?[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}[}]?$/,
	Ip     : Request.ServerVariables("REMOTE_ADDR"),
	Agent  : Request.ServerVariables("HTTP_USER_AGENT"),

	Language: function() {
		var hal = String(Request.ServerVariables("HTTP_ACCEPT_LANGUAGE")),
		regionSet = hal.split(",")[0];
		return regionSet.split("-")[0]
	},

	ResourceFile: function() {
		var LanguageSet = "uk",
		UserLanguage = this.Language(),
		LanguageCode = LanguageSet.indexOf(UserLanguage) > -1 ? UserLanguage : "en",	//default to English
		FileName     = ["server-", LanguageCode, ".xml"];
		return FileName.join("")
	},

	Validate: function(RoleId, UserGUID) {
		//Response.Write("<BR>Authenticate: RoleId=" + RoleId + "<BR>UserGUID=" + UserGUID + "<BR>ValidUser=" + ValidUser + "<BR>Token=" + Session("Token"));
		return RoleId == Session("RoleId") && this.Role[RoleId] && this.GuidRe.test(UserGUID) 
	},

	Authorize: function(RoleId) {
		var UserGUID = Session("UserGUID"),
		ValidUser    = this.Validate(RoleId, UserGUID),
		Done         = false;

		if (ValidUser) {
			try {
				Solaren.SetCmd("UserAuthorize");
				with (Cmd) {
					with (Parameters) {
						Append(CreateParameter("SessionId", adInteger, adParamInput, 10, Session.SessionID));
						Append(CreateParameter("UserId", adInteger, adParamInput, 10, Session("UserId")));
						Append(CreateParameter("RoleId", adTinyInt, adParamInput, 10, RoleId));
						Append(CreateParameter("UserIp", adVarChar, adParamInput, 15, this.Ip));
						Append(CreateParameter("UserGUID", adGUID, adParamInput, 40, UserGUID));
						Append(CreateParameter("Token", adChar, adParamInput, 32, Session("Token")));
						Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
					} Execute(adExecuteNoRecords);
					Done = Parameters.Item("Done").value;
				}
			} catch (ex) {
				Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
			} finally {
				Connect.Close();
			}
		}
		//Response.Write("<BR>Authorize: RoleId=" + SesRoleId + "<BR>SessionID=" + Session.SessionID + "<BR>UserGUID=" + UserGUID + "<BR>Token=" + Session("Token") + "<BR>ValidUser=" + ValidUser);
		return Done;
	},

	GetPswd: function() {
		var Pswd = "";
		while (Pswd == "") {
			for (var i=0; i < this.PswdLen; i++) {
				Pswd += String.fromCharCode(Solaren.GetRandInt(33, 126))
			};
			if (!this.PswdRe.test(Pswd)) Pswd = "";
		} return Pswd;
	}
}%>