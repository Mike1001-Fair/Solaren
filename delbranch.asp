<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2
User.ValidateAccess(Authorized, "GET");

with (Request) {
	var BranchId = QueryString("BranchId"),
	Deleted      = QueryString("Deleted");
}

try {
	Solaren.SetCmd("DelBranch");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("BranchId", adInteger, adParamInput, 10, BranchId));
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