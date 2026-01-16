<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/upsert.set" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
Form = Webserver.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Db.SetCmd("UpdateBank");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("BankId", adInteger, adParamInput, 10, Form.BankId));
			Append(CreateParameter("EdrpoCode", adVarChar, adParamInput, 10, Form.EdrpoCode));
			Append(CreateParameter("MfoCode", adVarChar, adParamInput, 10, Form.MfoCode));
			Append(CreateParameter("BankName", adVarChar, adParamInput, 30, Form.BankName));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		}
		Execute();
		var Done = Parameters.Item("Done").Value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {	
	Db.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Такий банк вже є");
}%>

