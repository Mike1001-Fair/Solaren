<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
	var ContractId = Form("ContractId"),
	PayId          = Form("PayId"),
	PayDate        = Form("PayDate"),
	PaySum         = Form("PaySum");
}

try {
	Solaren.SetCmd("UpdatePay");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("ContractId", adInteger, adParamInput, 10, ContractId));
			Append(CreateParameter("PayId", adInteger, adParamInput, 10, PayId));
			Append(CreateParameter("PayDate", adVarChar, adParamInput, 10, PayDate));
			Append(CreateParameter("PaySum", adVarChar, adParamInput, 20, PaySum));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").value;
	}

} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
} finally {	
	Connect.Close();
	Done ? Solaren.SysMsg(1, "") : Solaren.SysMsg(0, "Сума оплати бiльше боргу")
}%>