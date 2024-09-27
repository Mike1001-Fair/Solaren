<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
    var PerformerId = Form("PerformerId"),
	LastName    = Form("LastName"),
	FirstName   = Form("FirstName"),
	MiddleName  = Form("MiddleName"),
	Phone       = Form("Phone");
}

try {
	Solaren.SetCmd("UpdatePerformer");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("PerformerId", adInteger, adParamInput, 10, PerformerId));
			Append(CreateParameter("LastName", adVarChar, adParamInput, 20, LastName));
			Append(CreateParameter("FirstName", adVarChar, adParamInput, 20, FirstName));
			Append(CreateParameter("MiddleName", adVarChar, adParamInput, 20, MiddleName));
			Append(CreateParameter("Phone", adVarChar, adParamInput, 10, Phone));
		} Execute(adExecuteNoRecords);
	} Connect.Close();
	Solaren.SysMsg(1, "");
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}%>