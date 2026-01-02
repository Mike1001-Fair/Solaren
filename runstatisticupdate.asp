<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Include/upsert.inc" -->
<% var Authorized = User.RoleId == 0;
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("RunStatisticUpdate");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adInteger, adParamInput, 10, User.Id));
		}
		Execute(adExecuteNoRecords);
	}
	Message.Write(1, "");
	Solaren.Close();
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}%>

