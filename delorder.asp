<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
    var OrderId = QueryString("OrderId"),
	Deleted = QueryString("Deleted");
}

try {
	Solaren.SetCmd("DelOrder");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("OrderId", adInteger, adParamInput, 10, OrderId));
			Append(CreateParameter("Deleted", adBoolean, adParamInput, 1, Deleted));
		} Execute(adExecuteNoRecords);
	} Connect.Close();
	Solaren.SysMsg(1, "");  
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}%>