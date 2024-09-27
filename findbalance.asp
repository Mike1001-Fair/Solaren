<%@LANGUAGE="JavaScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") == 1;

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

try {
	Solaren.SetCmd("SelectOperator");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("Deleted", adBoolean, adParamInput, 1, 1));
		}
	}
	var rs = Cmd.Execute();
	Solaren.EOF(rs, 'Довідник операторiв пустий!');
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))	
}

with (Html) {
	SetHead("Баланс");
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindBalance" ACTION="listbalance.asp" METHOD="post" TARGET="_blank">
<INPUT TYPE="HIDDEN" NAME="OperatorName">
<H3 CLASS="HeadText">Баланс</H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<% Html.WriteMonthPeriod() %>
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<LABEL FOR="OperatorId">Оператор</LABEL>
	<% Html.WriteOperator(rs, -1);
	Connect.Close(); %>
	</FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn">&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>