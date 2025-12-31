<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Include/upsert.inc" -->
<% var Authorized = Session("RoleId") == 1,
Form = Solaren.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("NewCustomer");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("CustomerCode", adVarChar, adParamInput, 10, Form.CustomerCode));
			Append(CreateParameter("Phone", adVarChar, adParamInput, 10, Form.Phone));
			Append(CreateParameter("LastName", adVarChar, adParamInput, 20, Form.LastName));
			Append(CreateParameter("FirstName", adVarChar, adParamInput, 20, Form.FirstName));
			Append(CreateParameter("ThirdName", adVarChar, adParamInput, 20, Form.ThirdName));
			Append(CreateParameter("HouseId", adVarChar, adParamInput, 20, Form.HouseId));
			Append(CreateParameter("StreetId", adVarChar, adParamInput, 10, Form.StreetId));
			Append(CreateParameter("LocalityId", adInteger, adParamInput, 10, Form.LocalityId));
			Append(CreateParameter("AreaId", adVarChar, adParamInput, 10, Form.AreaId));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		}
		Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").Value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {	
	Solaren.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Споживач з таким кодом вже є")
}%>

