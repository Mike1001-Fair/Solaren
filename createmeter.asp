<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Message.Write(2, "Помилка авторизації");

with (Request) {
	var ContractId = Form("ContractId"),
	MeterCode      = Form("MeterCode"),
	SetDate        = Form("SetDate"),
	Capacity       = Form("Capacity"),
	kTransForm     = Form("kTransForm"),
	RecVal         = Form("RecVal"),
	RetVal         = Form("RetVal");
}

try {
	Solaren.SetCmd("NewMeter");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adSmallInt, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("ContractId", adInteger, adParamInput, 10, ContractId));
			Append(CreateParameter("MeterCode", adVarChar, adParamInput, 10, MeterCode));
			Append(CreateParameter("SetDate", adVarChar, adParamInput, 10, SetDate	));
			Append(CreateParameter("Capacity", adTinyInt, adParamInput, 10, Capacity));
			Append(CreateParameter("kTransForm", adTinyInt, adParamInput, 10, kTransForm));
			Append(CreateParameter("RecVal", adInteger, adParamInput, 10, RecVal));
			Append(CreateParameter("RetVal", adInteger, adParamInput, 10, RetVal));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {	
	Connect.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Лiчильник з таким номером вже є");
}%>
