<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2;
User.ValidateAccess(Authorized, "POST");

with (Request) {
	var CountryId = Form("CountryId"),
	CountryName   = Form("CountryName"),
	TldCode       = Form("TldCode"),
	IsoCode       = Form("IsoCode"),
	ItuCode       = Form("ItuCode");
}

try {
	Solaren.SetCmd("UpdateCountry");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("CountryId", adInteger, adParamInput, 10, CountryId));
			Append(CreateParameter("CountryName", adVarChar, adParamInput, 30, CountryName));    
			Append(CreateParameter("TldCode", adVarChar, adParamInput, 10, TldCode));
			Append(CreateParameter("IsoCode", adVarChar, adParamInput, 10, IsoCode));
			Append(CreateParameter("ItuCode", adVarChar, adParamInput, 10, ItuCode));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		}
		Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {	
	Solaren.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Така країна вже є");
}%>

