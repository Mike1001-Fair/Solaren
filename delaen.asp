<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/upsert.set" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2;
if (!Authorized) Message.Write(2, "Помилка авторизації");

with (Request) {
	var AenId = QueryString("AenId"),
	Deleted  = QueryString("Deleted");
}

try {
	Solaren.SetCmd("DelAen");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("AenId", adInteger, adParamInput, 10, AenId));
			Append(CreateParameter("Deleted", adBoolean, adParamInput, 1, Deleted));
		} Execute(adExecuteNoRecords);
	} Solaren.Close();
	Message.Write(1, "");  
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}%>

