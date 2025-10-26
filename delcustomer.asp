<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1,
Form = Solaren.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("DelCustomer");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("CustomerId", adInteger, adParamInput, 10, Form.CustomerId));
			Append(CreateParameter("Deleted", adBoolean, adParamInput, 1, Form.Deleted));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		}
		Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {	
	Solaren.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Помилка");
}%>



