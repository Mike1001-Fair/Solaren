<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
    var OrderDate  = Form("OrderDate"),
	ContractId = Form("ContractId"),
	JsonData   = Form("JsonData");
}

try {
	Solaren.SetCmd("NewOrder");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adSmallInt, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("OrderDate", adVarChar, adParamInput, 10, OrderDate));
			Append(CreateParameter("ContractId", adInteger, adParamInput, 10, ContractId));
			Append(CreateParameter("JsonData", adVarChar, adParamInput, 8000, JsonData));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} Execute(adExecuteNoRecords);
	} Connect.Close();
	Cmd.Parameters.Item("Done").value ? Solaren.SysMsg(1, "") : Solaren.SysMsg(0, "Помилка");
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex));
}%>
