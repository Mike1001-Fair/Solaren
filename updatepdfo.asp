<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
	var PdfoId = Form("PdfoId"),
	BegDate    = Form("BegDate"),
	EndDate    = Form("EndDate"),
	PdfoTax    = Form("PdfoTax");
}

try {
	Solaren.SetCmd("UpdatePdfo");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("PdfoId", adVarChar, adParamInput, 20, PdfoId));
			Append(CreateParameter("BegDate", adVarChar, adParamInput, 20, BegDate));
			Append(CreateParameter("EndDate", adVarChar, adParamInput, 20, EndDate));
			Append(CreateParameter("PdfoTax", adVarChar, adParamInput, 10, PdfoTax));
		} Execute(adExecuteNoRecords);
	} Connect.Close();
	Solaren.SysMsg(1, "");
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}%>