<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
Form = Solaren.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("UpdateStreet");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("StreetId", adInteger, adParamInput, 10, Form.StreetId));
			Append(CreateParameter("StreetType", adTinyInt, adParamInput, 10, Form.StreetType));
			Append(CreateParameter("StreetName", adVarChar, adParamInput, 30, Form.StreetName));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		}
		Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").Value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {	
	Solaren.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Така вулиця вже є");
}%>

