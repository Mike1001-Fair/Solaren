<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/upsert.set" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
Form = Solaren.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("UpdateLocality");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("LocalityId", adInteger, adParamInput, 10, Form.LocalityId));
			Append(CreateParameter("LocalityType", adTinyInt, adParamInput, 10, Form.LocalityType));
			Append(CreateParameter("LocalityName", adVarChar, adParamInput, 30, Form.LocalityName));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		}
		Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").Value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {	
	Solaren.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Такий пункт вже є");
}%>

