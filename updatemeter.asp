<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1;
User.ValidateAccess(Authorized, "POST");

with (Request) {
	var ContractId = Form("ContractId"),
	MeterId        = Form("MeterId"),
	MeterCode      = Form("MeterCode"),
	SetDate        = Form("SetDate"),
	Capacity       = Form("Capacity"),
	kTransForm     = Form("kTransForm"),
	RecVal         = Form("RecVal"),
	RetVal         = Form("RetVal");
}

try {
	Solaren.SetCmd("UpdateMeter");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("MeterId", adVarChar, adParamInput, 10, MeterId));
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
	Solaren.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Лiчильник з таким номером вже є");
}%>
