<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<% var Authorized = Session("RoleId") == 0;
if (!Authorized) Message.Write(2, "Помилка авторизації");
try {
	Solaren.SetCmd("RunReindexBase");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
		} Execute(adExecuteNoRecords);
	}
	Message.Write(1, "");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {	
	Connect.Close();
}%>
