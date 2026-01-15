<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/upsert.set" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
Form = Webserver.Map(Request.Form);
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("UpdateCountry");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("CountryId", adInteger, adParamInput, 10, Form.CountryId));
			Append(CreateParameter("CountryName", adVarChar, adParamInput, 30, Form.CountryName));    
			Append(CreateParameter("TldCode", adVarChar, adParamInput, 10, Form.TldCode));
			Append(CreateParameter("IsoCode", adVarChar, adParamInput, 10, Form.IsoCode));
			Append(CreateParameter("ItuCode", adVarChar, adParamInput, 10, Form.ItuCode));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		}
		Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").Value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {	
	Solaren.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Така країна вже є");
}%>

