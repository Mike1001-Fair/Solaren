<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") == 1,
Title = "Бюджетний код";

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

try {
	Solaren.SetCmd("SelectChief");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
		}
	}
	var rsChief = Cmd.Execute();
	Solaren.EOF(rsChief, 'Довiдник керiвникiв пустий');
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

with (Html) {
	SetHead(Title);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindBudgetCode" TARGET="_blank" ACTION="prnbudgetcode.asp" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="HIDDEN" NAME="ChiefName">
<H3 CLASS="HeadText"><%=Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET><LEGEND ALIGN="CENTER">Параметри</LEGEND>
	<LABEL>Керівник	<%Html.WriteChief(rsChief, -1)%></LABEL>
	</FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn">&#128270;Пошук</BUTTON></FORM></BODY></HTML>