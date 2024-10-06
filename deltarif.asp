<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<% var Authorized = Session("RoleId") == 1;

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
	var TarifId = QueryString("TarifId"),
	Deleted = QueryString("Deleted");
}

try {
	Solaren.SetCmd("DelTarif");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("TarifId", adInteger, adParamInput, 10, TarifId));
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