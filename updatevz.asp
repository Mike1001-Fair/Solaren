<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
	var VzId = Form("VzId"),
	BegDate  = Form("BegDate"),
	EndDate  = Form("EndDate"),
	VzTax    = Form("VzTax");
}

try {
	Solaren.SetCmd("UpdateVz");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("VzId", adVarChar, adParamInput, 20, VzId));
			Append(CreateParameter("BegDate", adVarChar, adParamInput, 20, BegDate));
			Append(CreateParameter("EndDate", adVarChar, adParamInput, 20, EndDate));
			Append(CreateParameter("VzTax", adVarChar, adParamInput, 10, VzTax));
		} Execute(adExecuteNoRecords);
	} Connect.Close();
	Solaren.SysMsg(1, "");
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}%>