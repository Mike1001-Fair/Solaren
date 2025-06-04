<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/referer.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Message.Write(2, "Помилка авторизації");

with (Request) {
    var ContractId = Form("ContractId"),
	OrderId    = Form("OrderId"),
	OrderDate  = Form("OrderDate"),
	JsonData   = Form("JsonData"),
	OrderSum   = Form("OrderSum");
}

try {
	Solaren.SetCmd("UpdateOrder");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("ContractId", adInteger, adParamInput, 10, ContractId));
			Append(CreateParameter("OrderId", adInteger, adParamInput, 10, OrderId));
			Append(CreateParameter("JsonData", adVarChar, adParamInput, 8000, JsonData));
			Append(CreateParameter("OrderDate", adVarChar, adParamInput, 10, OrderDate));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} Execute(adExecuteNoRecords);
	} Solaren.Close();
	Cmd.Parameters.Item("Done").value ? Message.Write(1, "") : Message.Write(0, "Помилка")
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}%>

