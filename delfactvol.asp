<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Include/upsert.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Message.Write(2, "Помилка авторизації");

with (Request) {
	var FactVolId = QueryString("FactVolId");
	Deleted       = QueryString("Deleted");
}

try {
	Solaren.SetCmd("DelFactVol");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("FactVolId", adInteger, adParamInput, 10, FactVolId));
			Append(CreateParameter("Deleted", adBoolean, adParamInput, 1, Deleted));
		} Execute(adExecuteNoRecords);
	} Solaren.Close();
	Message.Write(1, "");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}%>

