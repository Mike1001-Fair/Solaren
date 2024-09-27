<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
	var GroupId = Form("GroupId"),
	BegDate     = Form("BegDate"),
	EndDate     = Form("EndDate"),
	ExpDateBeg  = Form("ExpDateBeg"),
	ExpDateEnd  = Form("ExpDateEnd"),
	Tarif       = Form("Tarif");
}

try {
	Solaren.SetCmd("NewTarif");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("GroupId", adTinyInt, adParamInput, 1, GroupId));
			Append(CreateParameter("BegDate", adVarChar, adParamInput, 10, BegDate));
			Append(CreateParameter("EndDate", adVarChar, adParamInput, 10, EndDate));
			Append(CreateParameter("ExpDateBeg", adVarChar, adParamInput, 10, ExpDateBeg));
			Append(CreateParameter("ExpDateEnd", adVarChar, adParamInput, 10, ExpDateEnd));
			Append(CreateParameter("Tarif", adVarChar, adParamInput, 10, Tarif));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").value;
	}
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
} finally {
	Connect.Close();
	Done ? Solaren.SysMsg(1, "") : Solaren.SysMsg(0, "Тариф вже iснує");
}%>