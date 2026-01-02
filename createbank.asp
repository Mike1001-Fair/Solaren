<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE VIRTUAL="Solaren/Set/upsert.set" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
Form = Solaren.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("NewBank");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("EdrpoCode", adVarChar, adParamInput, 10, Form.EdrpoCode));
			Append(CreateParameter("MfoCode", adVarChar, adParamInput, 10, Form.MfoCode));
			Append(CreateParameter("BankName", adVarChar, adParamInput, 30, Form.BankName));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		}
		Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").Value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {	
	Solaren.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Банк з таким кодом МФО вже є");
}%>

