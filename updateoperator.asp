<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2;
if (!Authorized) Message.Write(2, "Помилка авторизації");

with (Request) {
	var OperatorId = Form("OperatorId"),
	SortCode       = Form("SortCode"),
	EdrpoCode      = Form("EdrpoCode"),
	OperatorName   = Form("OperatorName");
}

try {
	Solaren.SetCmd("UpdateOperator");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("OperatorId", adInteger, adParamInput, 10, OperatorId));
			Append(CreateParameter("SortCode", adTinyInt, adParamInput, 10, SortCode));
			Append(CreateParameter("EdrpoCode", adVarChar, adParamInput, 10, EdrpoCode));
			Append(CreateParameter("OperatorName", adVarChar, adParamInput, 30, OperatorName));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} Execute(adExecuteNoRecords);
	}
	Cmd.Parameters.Item("Done").value ? Message.Write(1, "") : Message.Write(0, "Оператор з таким кодом вже є");
	Connect.Close();
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}%>