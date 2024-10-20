<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% Resource.Load(User.ResourceFile());
var LoginId = Request.Form("LoginId"),
Pswd = Request.Form("Pswd"),
AuthenticationError = Dictionary.Item("AuthenticationError");

if (!Solaren.HTTPMethod("POST", 3)) Solaren.SysMsg(2, AuthenticationError);

try {
	Solaren.SetCmd("Login");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("LoginId", adVarChar, adParamInput, 10, LoginId));
			Append(CreateParameter("Pswd", adVarChar, adParamInput, 10, Pswd));
			Append(CreateParameter("UserIp", adVarChar, adParamInput, 15, User.Ip));
			Append(CreateParameter("UserAgent", adVarChar, adParamInput, 130, User.Agent));
			Append(CreateParameter("SessionId", adInteger, adParamInput, 10, Session.SessionID));
			Append(CreateParameter("RoleId", adTinyInt, adParamOutput, 10, 0));
			Append(CreateParameter("UserId", adInteger, adParamOutput, 10, 0));
			Append(CreateParameter("StartSysDate", adVarChar, adParamOutput, 10, ""));
			Append(CreateParameter("OperDate", adVarChar, adParamOutput, 10, ""));
			Append(CreateParameter("HoursLimit", adVarChar, adParamOutput, 10, ""));
			Append(CreateParameter("SysConfig", adTinyInt, adParamOutput, 1, 0));
			Append(CreateParameter("ShowMsg", adBoolean, adParamOutput, 1, 0));
			Append(CreateParameter("MsgText", adVarChar, adParamOutput, 800, ""));
			Append(CreateParameter("UserGUID", adGUID, adParamOutput, 40));
			Append(CreateParameter("Token", adChar, adParamOutput, 32));
		} Execute(adExecuteNoRecords);
		with (Parameters) {
			var RoleId = Item("RoleId").value,
			UserGUID   = Item("UserGUID").value,
			SysConfig  = Item("SysConfig").value;
			Session("RoleId")       = RoleId;
			Session("UserGUID")     = UserGUID;
			Session("UserId")       = Item("UserId").value;
			Session("Token")        = Item("Token").value;
			Session("StartSysDate") = Item("StartSysDate").value;
			Session("OperDate")     = Item("OperDate").value;
			Session("HoursLimit")   = Item("HoursLimit").value;
			Session("MsgText")      = Item("MsgText").value;
		}
	}
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
} finally {	
	Connect.Close();
	if (User.Validate(RoleId, UserGUID)) {
		var ymd  = Session("OperDate").split("-"),
		Today    = new Date(),
		EndDate  = new Date(ymd[0], ymd[1], 0),
		NextDate = new Date(ymd[0], +ymd[1] + 1, 0),
		SysCfg   = SysConfig.toString(2).padStart(2).split('');
		Session("OperMonth") = Session("OperDate").slice(0, 7);
		Session("Today")     = Today.toStr();
		Session("EndDate")   = EndDate.toStr();
		Session("NextDate")  = NextDate.toStr();
		Solaren.SetSessionVar(SysCfg);
		Html.SetHead(Dictionary.Item("DefaultTitle"));
		Html.WriteMenu(RoleId, 1);
	} else {
		Solaren.SysMsg(2, AuthenticationError)
	}
}%>