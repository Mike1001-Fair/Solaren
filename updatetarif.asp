<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1;
User.ValidateAccess(Authorized, "POST");

with (Request) {
	var TarifId = Form("TarifId"),
	GroupId     = Form("GroupId"),
	BegDate     = Form("BegDate"),
	EndDate     = Form("EndDate"),
	ExpDateBeg  = Form("ExpDateBeg"),
	ExpDateEnd  = Form("ExpDateEnd"),
	Tarif       = Form("Tarif");
}

try {
	Solaren.SetCmd("UpdateTarif");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("TarifId", adSmallInt, adParamInput,10, TarifId));
			Append(CreateParameter("GroupId", adTinyInt, adParamInput, 1, GroupId));
			Append(CreateParameter("BegDate", adVarChar, adParamInput, 10, BegDate));
			Append(CreateParameter("EndDate", adVarChar, adParamInput, 10, EndDate));
			Append(CreateParameter("ExpDateBeg", adVarChar, adParamInput, 10, ExpDateBeg));
			Append(CreateParameter("ExpDateEnd", adVarChar, adParamInput, 10, ExpDateEnd));
			Append(CreateParameter("Tarif", adVarChar, adParamInput, 10, Tarif));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} Execute(adExecuteNoRecords);
	} Connect.Close();
	Cmd.Parameters.Item("Done").value ? Solaren.SysMsg(1, "") : Solaren.SysMsg(0, "Помилка")
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}%>