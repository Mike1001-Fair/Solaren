<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/upsert.set" -->
<% var Authorized = User.RoleId == 1,
Form = Solaren.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("UpdateTarif");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("TarifId", adSmallInt, adParamInput,10, Form.TarifId));
			Append(CreateParameter("GroupId", adTinyInt, adParamInput, 1, Form.GroupId));
			Append(CreateParameter("BegDate", adVarChar, adParamInput, 10, Form.BegDate));
			Append(CreateParameter("EndDate", adVarChar, adParamInput, 10, Form.EndDate));
			Append(CreateParameter("ExpDateBeg", adVarChar, adParamInput, 10, Form.ExpDateBeg));
			Append(CreateParameter("ExpDateEnd", adVarChar, adParamInput, 10, Form.ExpDateEnd));
			Append(CreateParameter("Tarif", adVarChar, adParamInput, 10, Form.Tarif));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} 
		Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").Value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {	
	Solaren.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Помилка")
}%>