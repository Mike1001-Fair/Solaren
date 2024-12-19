<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->

<% var Authorized = User.RoleId == 1;
User.ValidateAccess(Authorized, "GET");

function SetSessionVar() {
	var OperDate = Cmd.Parameters.Item("OperDate").value,
	ymd          = OperDate.split("-"),
	Today        = new Date(),
	EndDate      = new Date(ymd[0], ymd[1], 0),
	NextDate     = new Date(ymd[0], +ymd[1] + 1, 0);
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
	}
	SetSessionVar();
	Solaren.SysMsg(1, "");
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
} finally {	
	Connect.Close();
}%>