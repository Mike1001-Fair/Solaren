<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/upsert.set" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
Form = Webserver.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("DelChiefDoc");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("DocId", adInteger, adParamInput, 10, Form.DocId));
			Append(CreateParameter("Deleted", adBoolean, adParamInput, 1, Form.Deleted));
		}
		Execute(adExecuteNoRecords);
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Solaren.Close();
	Message.Write(1, "");
}%>

