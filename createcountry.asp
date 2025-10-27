<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2;
User.CheckAccess(Authorized, "POST");

with (Request) {
	var CountryName = Form("CountryName"),
	TldCode         = Form("TldCode"),
	IsoCode         = Form("IsoCode"),
	ItuCode         = Form("ItuCode");
}

try {
	Solaren.SetCmd("NewCountry");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("CountryName", adVarChar, adParamInput, 30, CountryName));    
			Append(CreateParameter("TldCode", adVarChar, adParamInput, 10, TldCode));
			Append(CreateParameter("IsoCode", adVarChar, adParamInput, 10, IsoCode));
			Append(CreateParameter("ItuCode", adVarChar, adParamInput, 10, ItuCode));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} 
		Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").Value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {	
	Solaren.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Країна з таким кодом " + IsoCode + " вже є");
}%>

