<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2;
if (!Authorized) Message.Write(2, "Помилка авторизації");

with (Request) {
	var PdfoId = QueryString("PdfoId"),
	Deleted    = QueryString("Deleted");
}

try {
	Solaren.SetCmd("DelPdfo");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("PdfoId", adInteger, adParamInput, 10, PdfoId));
			Append(CreateParameter("Deleted", adBoolean, adParamInput, 1, Deleted));
		} Execute(adExecuteNoRecords);
	} Connect.Close();
	Message.Write(1, "");  
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}%>
