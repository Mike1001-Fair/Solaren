<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2;
User.ValidateAccess(Authorized, "POST");

with (Request) {
	var ChiefTitleId = QueryString("ChiefTitleId"),
	Deleted          = QueryString("Deleted");
}

try {
	Solaren.SetCmd("DelChiefTitle");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("ChiefTitleId", adInteger, adParamInput, 10, ChiefTitleId));
			Append(CreateParameter("Deleted", adBoolean, adParamInput, 1, Deleted));
		} Execute(adExecuteNoRecords);
	} Connect.Close();
	Message.Write(1, "");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}%>