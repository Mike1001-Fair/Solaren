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

if (!Solaren.HTTPMethod("POST", 3)) {
	Solaren.SysMsg(2, AuthenticationError);
}

try {
	Solaren.SetCmd("Login");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("LoginId", adVarChar, adParamInput, 10, LoginId));
			Append(CreateParameter("Pswd", adVarChar, adParamInput, 10, Pswd));
			Append(CreateParameter("UserIp", adVarChar, adParamInput, 15, User.Ip));
			Append(CreateParameter("UserAgent", adVarChar, adParamInput, 130, User.Agent));
			Append(CreateParameter("SessionId", adInteger, adParamInput, 10, Session.SessionID));
		}
	}
	var rs = Cmd.Execute();
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
} finally {
	if (rs.EOF) {
		Solaren.SysMsg(2, AuthenticationError);
	} else {
		var RoleId = rs.Fields("RoleId").value,
		SysConfig  = rs.Fields("SysConfig").value,
		OperDate   = rs.Fields("OperDate").value,
		ymd        = OperDate.split("-"),
		Today      = new Date(),
		EndDate    = new Date(ymd[0], ymd[1], 0),
		NextDate   = new Date(ymd[0], +ymd[1] + 1, 0),
		SysCfg     = SysConfig.toString(2).padStart(2).split('');

		Session("UserGUID")   = rs.Fields("UserGUID").value;
		Session("UserId")     = rs.Fields("UserId").value;
		Session("Token")      = rs.Fields("Token").value;
		Session("HoursLimit") = rs.Fields("HoursLimit").value;
		Session("MsgText")    = rs.Fields("MsgText").value;
		Session("RoleId")     = RoleId;
		Session("OperDate")   = OperDate;
		Session("OperMonth")  = OperDate.slice(0, 7);
		Session("Today")      = Today.toStr();
		Session("EndDate")    = EndDate.toStr();
		Session("NextDate")   = NextDate.toStr();
		Solaren.SetSessionVar(SysCfg);
		rs.Close();

		Html.SetHead(Dictionary.Item("DefaultTitle"));
		Html.WriteMenu(RoleId, 1);
	}
	Connect.Close();
}%>