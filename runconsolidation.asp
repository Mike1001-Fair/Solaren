<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1;
User.ValidateAccess(Authorized, "POST");

try {
	Solaren.SetCmd("RunConsolidation");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
		} Execute(adExecuteNoRecords);
	}
	Solaren.SysMsg(1, "");
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
} finally {	
	Connect.Close();
}%>