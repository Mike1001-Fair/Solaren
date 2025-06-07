<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->

<% var Authorized = User.RoleId == 1;
User.ValidateAccess(Authorized, "POST");

function SetSessionDate(OperDate) {
	var ymd  = OperDate.split("-"),
	EndDate  = new Date(ymd[0], ymd[1], 0),
	NextDate = new Date(ymd[0], +ymd[1] + 1, 0);
	Session("OperDate") = OperDate;
	Session("EndDate")  = EndDate.toStr(0);
	Session("NextDate") = NextDate.toStr(0);
}

try {
	Solaren.SetCmd("RunMonthClosing");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("OperDate", adVarChar, adParamOutput, 10, ""));
		} Execute();
		var OperDate = Parameters.Item("OperDate").value,
	}
	Solaren.SetSessionDate(OperDate);
	Message.Write(1, "");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {	
	Solaren.Close();
}%>

