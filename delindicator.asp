<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1;
User.ValidateAccess(Authorized, "POST");

with (Request) {
	var IndicatorId = Form("IndicatorId"),
	Deleted         = Form("Deleted");
}

try {
	Solaren.SetCmd("DelIndicator");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("IndicatorId", adInteger, adParamInput, 10, IndicatorId));
			Append(CreateParameter("Deleted", adBoolean, adParamInput, 1, Deleted));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Solaren.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Помилка");
}%>

