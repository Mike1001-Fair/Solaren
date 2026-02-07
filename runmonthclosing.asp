<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/upsert.set" -->
<% var Authorized = User.RoleId == 1;
User.CheckAccess(Authorized, "POST");

try {
	Db.SetCmd("RunMonthClosing");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adInteger, adParamInput, 10, User.Id));
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
	Db.Close();
}%>

