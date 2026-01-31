<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/upsert.set" -->
<% var Authorized = User.RoleId == 1,
Form = Webserver.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Db.SetCmd("NewPdfo");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("BegDate", adVarChar, adParamInput, 10, Form.BegDate));
			Append(CreateParameter("EndDate", adVarChar, adParamInput, 10, Form.EndDate));
			Append(CreateParameter("PdfoTax", adVarChar, adParamInput, 10, Form.PdfoTax));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		}
		Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").Value;
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {	
	Db.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Помилка")
}%>

