<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/upsert.set" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2;
if (!Authorized) Message.Write(2, "Помилка авторизації");

with (Request) {
	var PdfoId = Form("PdfoId"),
	BegDate    = Form("BegDate"),
	EndDate    = Form("EndDate"),
	PdfoTax    = Form("PdfoTax");
}

try {
	Solaren.SetCmd("UpdatePdfo");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("PdfoId", adVarChar, adParamInput, 20, PdfoId));
			Append(CreateParameter("BegDate", adVarChar, adParamInput, 20, BegDate));
			Append(CreateParameter("EndDate", adVarChar, adParamInput, 20, EndDate));
			Append(CreateParameter("PdfoTax", adVarChar, adParamInput, 10, PdfoTax));
		} Execute(adExecuteNoRecords);
	} Solaren.Close();
	Message.Write(1, "");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}%>

