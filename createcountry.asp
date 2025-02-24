<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2;
User.ValidateAccess(Authorized, "POST");

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
		var Done = Parameters.Item("Done").value;
	}
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
} finally {	
	Connect.Close();
	Done ? Solaren.SysMsg(1, "") : Solaren.SysMsg(0, "Країна з таким кодом " + IsoCode + " вже є");
}%>