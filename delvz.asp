<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

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
	} Connect.Close();
	Solaren.SysMsg(1, "");  
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}%>