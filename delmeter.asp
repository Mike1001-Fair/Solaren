<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<% var Authorized = Session("RoleId") == 1;

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
	var MeterId = QueryString("MeterId"),
	Deleted     = QueryString("Deleted");
}

try {
	Solaren.SetCmd("DelMeter");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("MeterId", adInteger, adParamInput, 10, MeterId));
			Append(CreateParameter("Deleted", adBoolean, adParamInput, 1, Deleted));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").value;
	}
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
} finally {	
	Connect.Close();
	Done ? Solaren.SysMsg(1, "") : Solaren.SysMsg(0, "Помилка");
}%>