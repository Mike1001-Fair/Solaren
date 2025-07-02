<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1,
Form = Solaren.Map(Request.Form);
User.ValidateAccess(Authorized, "POST");

try {
	Solaren.SetCmd("UpdateMeter");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("MeterId", adVarChar, adParamInput, 10, Form.MeterId));
			Append(CreateParameter("ContractId", adInteger, adParamInput, 10, Form.ContractId));
			Append(CreateParameter("MeterCode", adVarChar, adParamInput, 10, Form.MeterCode));
			Append(CreateParameter("SetDate", adVarChar, adParamInput, 10, Form.SetDate));
			Append(CreateParameter("Capacity", adTinyInt, adParamInput, 10, Form.Capacity));
			Append(CreateParameter("kTransForm", adTinyInt, adParamInput, 10, Form.kTransForm));
			Append(CreateParameter("RecVal", adInteger, adParamInput, 10, Form.RecVal));
			Append(CreateParameter("RetVal", adInteger, adParamInput, 10, Form.RetVal));
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

