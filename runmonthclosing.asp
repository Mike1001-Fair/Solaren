<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

function SetSessionVar() {
	var OperDate = Cmd.Parameters.Item("OperDate").value,
	OperMonth    = OperDate.slice(0, 7),
	ym           = OperMonth.split("-"),
	Today        = new Date(),
	EndDate      = new Date(ym[0], ym[1], 0),
	NextDate     = new Date(ym[0], +ym[1]+1, 0);
	Session("OperDate")  = OperDate
	Session("OperMonth") = OperMonth;
	Session("EndDate")   = OperMonth + "-" + EndDate.getDate();
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