<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2;
User.ValidateAccess(Authorized, "POST");

with (Request) {
	var StreetId = Form("StreetId"),
	StreetType   = Form("StreetType"),
	StreetName   = Form("StreetName");
}

try {
	Solaren.SetCmd("UpdateStreet");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("StreetId", adInteger, adParamInput, 10, StreetId));
			Append(CreateParameter("StreetType", adTinyInt, adParamInput, 10, StreetType));
			Append(CreateParameter("StreetName", adVarChar, adParamInput, 30, StreetName));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").value;
	}
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
} finally {	
	Connect.Close();
	Done ? Solaren.SysMsg(1, "") : Solaren.SysMsg(0, "Така вулиця вже є");
}%>