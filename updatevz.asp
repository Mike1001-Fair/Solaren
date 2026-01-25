<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/upsert.set" -->
<% var Authorized = User.RoleId == 1,
Form = Webserver.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Db.SetCmd("UpdateVz");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("VzId", adVarChar, adParamInput, 20, Form.VzId));
			Append(CreateParameter("BegDate", adVarChar, adParamInput, 20, Form.BegDate));
			Append(CreateParameter("EndDate", adVarChar, adParamInput, 20, Form.EndDate));
			Append(CreateParameter("VzTax", adVarChar, adParamInput, 10, Form.VzTax));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		}
		Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").Value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {	
	Db.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Помилка")
}%>

