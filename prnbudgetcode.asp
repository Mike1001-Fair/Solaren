<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->

<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
	var ChiefName = Form("ChiefName");
}

try {
	Solaren.SetCmd("GetBudgetCode");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
		}
	}
	var rs = Cmd.Execute();
	Solaren.EOF(rs, 'Iнформацiю не знайдено');
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

with (rs) {
    var ContractorName = Fields("ContractorName").value,
	BudgetItem     = Fields("BudgetItem").value;
	Close();
} Connect.Close();

var Today = new Date(),
ReportDate = Today.toStr().formatDate("-");
Html.SetHead("Бюджетний код")%>

<BODY CLASS="PrnBody">
<DIV ALIGN="CENTER">
<H4 STYLE="margin: 0 0 10 0">Код статтi видаткiв: <%=BudgetItem%>, прiоритет: П-1</H4>
<TABLE CLASS="PrnTable">
<TR ALIGN="CENTER"><TD>Дата</TD><TD>ПIБ</TD><TD>Пiдпис</TD></TR>
<TR ALIGN="CENTER"><TD><%=ReportDate%></TD><TD><%=ChiefName%></TD><TD STYLE="width: 100; padding: 9 0 9 0">&nbsp</TD></TR>
<TR ALIGN="CENTER"><TD><%=ReportDate%></TD><TD><%=ContractorName%></TD><TD STYLE="width: 100; padding: 9 0 9 0">&nbsp</TD></TR>
<TR><TD COLSPAN="3" ALIGN="CENTER">Вiддiл бюджетного планування i контролю</TD></TR>
<TR><TD ALIGN="CENTER">&nbsp</TD><TD STYLE="width: 200">&nbsp</TD><TD STYLE="width: 100; padding: 9 0 9 0">&nbsp</TD></TR>
</TABLE></DIV></BODY></HTML>