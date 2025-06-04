<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/referer.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Message.Write(2, "Помилка авторизації");

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
	Message.Write(3, Message.Error(ex))
} finally {
	Solaren.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Тариф вже iснує");
}%>

