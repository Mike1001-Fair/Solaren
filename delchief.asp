<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
Form = Solaren.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("DelChief");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("ChiefId", adInteger, adParamInput, 10, Form.ChiefId));
			Append(CreateParameter("Deleted", adBoolean, adParamInput, 1, Form.Deleted));
		} Execute(adExecuteNoRecords);
	}
	Solaren.Close();
	Message.Write(1, "");  
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}%>

