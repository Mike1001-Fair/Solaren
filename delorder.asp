<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1;
User.ValidateAccess(Authorized, "POST");

with (Request) {
    var OrderId = Form("OrderId"),
	Deleted = Form("Deleted");
}

try {
	Solaren.SetCmd("DelOrder");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("OrderId", adInteger, adParamInput, 10, OrderId));
			Append(CreateParameter("Deleted", adBoolean, adParamInput, 1, Deleted));
		} Execute(adExecuteNoRecords);
	} Solaren.Close();
	Message.Write(1, "");  
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}%>
