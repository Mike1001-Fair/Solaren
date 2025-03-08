<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Message.Write(2, "Помилка авторизації");

with (Request) {
	var ContractId = Form("ContractId"),
	PayDate        = Form("PayDate"),
	PaySum         = Form("PaySum");
}

try {
	Solaren.SetCmd("NewPay");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("PayDate", adVarChar, adParamInput, 10, PayDate));
			Append(CreateParameter("ContractId", adInteger, adParamInput, 10, ContractId));
			Append(CreateParameter("PaySum", adVarChar, adParamInput, 20, PaySum));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {	
	Solaren.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Сума оплати бiльше боргу")
}%>

