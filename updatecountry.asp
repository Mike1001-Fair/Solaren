<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
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
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
} finally {	
	Connect.Close();
	Done ? Solaren.SysMsg(1, "") : Solaren.SysMsg(0, "Така країна вже є");
}%>