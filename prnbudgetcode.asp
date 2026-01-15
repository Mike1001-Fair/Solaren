<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/list.set" -->
<% var Authorized = User.RoleId == 1,
Form = Webserver.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("GetBudgetCode");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adInteger, adParamInput, 10, User.Id));
		}
	}
	var rs = Solaren.Execute("GetBudgetCode");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	var Record = Webserver.Map(rs.Fields),
	ReportDate = Month.Today.toStr(0).formatDate("-");
	rs.Close();
	Solaren.Close();
	Html.SetHead("Бюджетний код");
}%>

<BODY CLASS="PrnBody">
<DIV ALIGN="CENTER">
<H4 STYLE="margin: 0 0 10 0">Код статтi видаткiв: <%=Record.BudgetItem%>, прiоритет: П-1</H4>
<TABLE CLASS="PrnTable">
	<TR ALIGN="CENTER"><TD>Дата</TD><TD>ПIБ</TD><TD>Пiдпис</TD></TR>
	<TR ALIGN="CENTER"><TD><%=ReportDate%></TD><TD><%=Form.ChiefName%></TD><TD STYLE="width: 100; padding: 9 0 9 0">&nbsp</TD></TR>
	<TR ALIGN="CENTER"><TD><%=ReportDate%></TD><TD><%=Record.ContractorName%></TD><TD STYLE="width: 100; padding: 9 0 9 0">&nbsp</TD></TR>
	<TR><TD COLSPAN="3" ALIGN="CENTER">Вiддiл бюджетного планування i контролю</TD></TR>
	<TR><TD ALIGN="CENTER">&nbsp</TD><TD STYLE="width: 200">&nbsp</TD><TD STYLE="width: 100; padding: 9 0 9 0">&nbsp</TD></TR>
</TABLE></DIV></BODY></HTML>


