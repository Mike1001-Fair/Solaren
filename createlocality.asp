<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
Form = Solaren.Parse();

User.CheckAccess(Authorized, "POST");
try {
	Solaren.SetCmd("NewLocality");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("LocalityType", adTinyInt, adParamInput, 10, Form.LocalityType));
			Append(CreateParameter("LocalityName", adVarChar, adParamInput, 30, Form.LocalityName));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} 
		Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {	
	Solaren.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Такий пункт вже є");
}%>

