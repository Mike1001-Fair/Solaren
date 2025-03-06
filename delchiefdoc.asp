<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2;
User.ValidateAccess(Authorized, "POST");

with (Request) {
	var DocId = QueryString("DocId");
	Deleted   = QueryString("Deleted");
}

try {
	Solaren.SetCmd("DelChiefDoc");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("DocId", adInteger, adParamInput, 10, DocId));
			Append(CreateParameter("Deleted", adBoolean, adParamInput, 1, Deleted));
		} Execute(adExecuteNoRecords);
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Connect.Close();
	Message.Write(1, "");
}%>
