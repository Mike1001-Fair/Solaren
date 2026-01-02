<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/upsert.set" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2;
if (!Authorized) Message.Write(2, "Помилка авторизації");

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
	} Solaren.Close();
	Cmd.Parameters.Item("Done").Value ? Message.Write(1, "") : Message.Write(0, "Помилка");
} catch (ex) {
	Message.Write(3, Message.Error(ex));
}%>


