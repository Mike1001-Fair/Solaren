<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/session.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<% var Form = Solaren.Match(Application("AppName")) ? Solaren.Map(Request.Form) : {},
validCreds = User.ValidateCredentials(Form);

User.ValidateAccess(validCreds, "POST");

try {
	Solaren.SetCmd("Login");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserName", adVarChar, adParamInput, 10, Form.UserName));
			Append(CreateParameter("Pswd", adVarChar, adParamInput, 10, Form.Pswd));
			Append(CreateParameter("UserIp", adVarChar, adParamInput, 15, User.Ip));
			Append(CreateParameter("UserAgent", adVarChar, adParamInput, 130, User.Agent));
			Append(CreateParameter("SessionId", adInteger, adParamInput, 10, Session.SessionID));
		}
	}
	var rs = Cmd.Execute();
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Resource.Load(User.ResourceFile());
	if (rs.EOF) {
		rs.Close();
		Solaren.Close();
		Message.Write(2, Dictionary.Item("AuthenticationError"));
	} else {
		SessionManager.SetVar(rs);
		rs.Close();
		Solaren.Close();
		Html.SetHead(Dictionary.Item("DefaultTitle"), 1);
		Menu.Write(1);
	}
}%>
