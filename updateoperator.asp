<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Include/upsert.inc" -->
<% var Authorized = User.RoleId == 1,
Form = Solaren.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("UpdateOperator");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("OperatorId", adInteger, adParamInput, 10, Form.OperatorId));
			Append(CreateParameter("SortCode", adTinyInt, adParamInput, 10, Form.SortCode));
			Append(CreateParameter("EdrpoCode", adVarChar, adParamInput, 10, Form.EdrpoCode));
			Append(CreateParameter("OperatorName", adVarChar, adParamInput, 30, Form.OperatorName));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		}
		Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").Value;
	}
	Solaren.Close();
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {	
	Solaren.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Оператор з таким кодом вже є")
}%>

