<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = Session("RoleId") == 2,
Form = Solaren.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("NewIndicator");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adInteger, adParamInput, 10, User.Id));
			Append(CreateParameter("ReportDate", adVarChar, adParamInput, 10, Form.ReportDate));
			Append(CreateParameter("MeterId", adInteger, adParamInput, 10, Form.MeterId));
			Append(CreateParameter("RecVal", adInteger, adParamInput, 10, Form.RecVal));
			Append(CreateParameter("RetVal", adInteger, adParamInput, 10, Form.RetVal));
			Append(CreateParameter("PrevDate", adVarChar, adParamInput, 10, Form.PrevDate));
			Append(CreateParameter("RecSaldo", adInteger, adParamInput, 10, Form.RecSaldo));
			Append(CreateParameter("RetSaldo", adInteger, adParamInput, 10, Form.RetSaldo));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		}
		Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").Value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {	
	Solaren.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Показники з такою або<br>бiльш новою датою вже є")
}%>

