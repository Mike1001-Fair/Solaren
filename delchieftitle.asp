<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/upsert.set" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
Form = Webserver.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("DelChiefTitle");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("ChiefTitleId", adInteger, adParamInput, 10, Form.ChiefTitleId));
			Append(CreateParameter("Deleted", adBoolean, adParamInput, 1, Form.Deleted));
		} Execute(adExecuteNoRecords);
	}
	Solaren.Close();
	Message.Write(1, "");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}%>

