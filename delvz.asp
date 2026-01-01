<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Include/upsert.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2;
if (!Authorized) Message.Write(2, "Помилка авторизації");

with (Request) {
	var VzId = QueryString("VzId"),
	Deleted  = QueryString("Deleted");
}

try {
	Solaren.SetCmd("DelVz");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("VzId", adInteger, adParamInput, 10, VzId));
			Append(CreateParameter("Deleted", adBoolean, adParamInput, 1, Deleted));
		} Execute(adExecuteNoRecords);
	} Solaren.Close();
	Message.Write(1, "");  
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}%>

