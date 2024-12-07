<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 0;
User.ValidateAccess(Authorized, "POST");

with (Request) {
    var UserId  = QueryString("UserId"),
	Deleted = QueryString("Deleted");
}

try {
	Solaren.SetCmd("DelUser");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adInteger, adParamInput, 10, UserId));
			Append(CreateParameter("Deleted", adBoolean, adParamInput, 1, Deleted));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").value;
	}
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex));
} finally {
	Connect.Close();
	Done ? Solaren.SysMsg(1, "") : Solaren.SysMsg(0, "Помилка");
}%>