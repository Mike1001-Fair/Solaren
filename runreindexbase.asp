<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/upsert.set" -->
<% var Authorized = User.RoleId == 0;
User.CheckAccess(Authorized, "POST");

try {
	Db.SetCmd("RunReindexBase");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adInteger, adParamInput, 10, User.Id));
		}
		Execute(adExecuteNoRecords);
	}
	Message.Write(1, "");
	Db.Close();
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}%>

