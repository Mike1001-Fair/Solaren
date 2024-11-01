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
		Title = Dictionary.Item("DefaultTitle");
		Solaren.SetSessionVar(rs);
		Html.SetHead(Title);
		Html.WriteMenu(RoleId, 1);
	}
	rs.Close();
	Connect.Close();
}%>