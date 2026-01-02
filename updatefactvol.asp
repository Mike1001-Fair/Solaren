<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE VIRTUAL="Solaren/Set/upsert.set" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Message.Write(2, "Помилка авторизації");

with (Request) {
	var FactVolId = Form("FactVolId"),
	ContractId    = Form("ContractId"),
	BegDate       = Form("BegDate"),
	EndDate       = Form("EndDate"),
	RecVol        = Form("RecVol"),
	RetVol        = Form("RetVol");
}

try {
	Solaren.SetCmd("UpdateFactVol");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adInteger, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("FactVolId", adInteger, adParamInput,10, FactVolId));
			Append(CreateParameter("ContractId", adSmallInt, adParamInput, 10, ContractId));
			Append(CreateParameter("BegDate", adVarChar, adParamInput, 10, BegDate));
			Append(CreateParameter("EndDate", adVarChar, adParamInput, 10, EndDate));
			Append(CreateParameter("RecVol", adInteger, adParamInput, 10, RecVol));
			Append(CreateParameter("RetVol", adInteger, adParamInput, 10, RetVol));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").Value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {	
	Solaren.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Помилка")
}%>

