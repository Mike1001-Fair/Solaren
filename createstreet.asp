<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2;
User.ValidateAccess(Authorized, "POST");

with (Request) {
	var StreetType = Form("StreetType"),
	StreetName     = Form("StreetName");
}

try {
	Solaren.SetCmd("NewStreet");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adInteger, adParamInput, 10, Session("UserId")));
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