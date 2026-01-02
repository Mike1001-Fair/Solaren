<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Include/upsert.inc" -->
<% var Authorized = User.RoleId == 1;
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("RunMonthClosing");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("OperDate", adVarChar, adParamOutput, 10, ""));
		}
		Execute(adExecuteNoRecords);
	}
	var OperDate = Cmd.Parameters.Item("OperDate").Value;
	SessionManager.SetDate(OperDate);
	Message.Write(1, "");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {	
	Solaren.Close();
}%>

