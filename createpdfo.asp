<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
	var BegDate = Form("BegDate"),
	EndDate     = Form("EndDate"),
	PdfoTax     = Form("PdfoTax");
}

try {
	Solaren.SetCmd("NewPdfo");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("BegDate", adVarChar, adParamInput, 10, BegDate));
			Append(CreateParameter("EndDate", adVarChar, adParamInput, 10, EndDate));
			Append(CreateParameter("PdfoTax", adVarChar, adParamInput, 10, PdfoTax));
		} Execute(adExecuteNoRecords);
	} Connect.Close();
	Solaren.SysMsg(1, "");
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}%>