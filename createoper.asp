<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/lib.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
	var ContractId = Form("ContractId"),
	BegDate        = Form("BegDate"),
	EndDate        = Form("EndDate"),
	RetVol         = Form("RetVol"),
	VolCost        = Form("VolCost");
}

try {
	Solaren.SetCmd("NewOper");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adInteger, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("ContractId", adSmallInt, adParamInput, 10, ContractId));
			Append(CreateParameter("BegDate", adVarChar, adParamInput, 10, BegDate));
			Append(CreateParameter("EndDate", adVarChar, adParamInput, 10, EndDate));
			Append(CreateParameter("RetVol", adInteger, adParamInput, 10, RetVol));
			Append(CreateParameter("VolCost", adInteger, adParamInput, 10, VolCost));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} Execute(adExecuteNoRecords);
	} Connect.Close();
	Cmd.Parameters.Item("Done").value ? Solaren.SysMsg(1, "") : Solaren.SysMsg(0, "Операція вже iснує")
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}%>