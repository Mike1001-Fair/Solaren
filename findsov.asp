<%@LANGUAGE="JavaScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") == 1,
TitleHead = "Сальдо-оборотна вiдомость";

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Html) {
	SetHead(TitleHead);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindSov" ACTION="listsov.asp" METHOD="post" TARGET="_blank">

<H3 CLASS="HeadText"><%=TitleHead%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET>
	<LEGEND>Перiод</LEGEND>
	<INPUT TYPE="Month" NAME="ReportMonth" VALUE="<%=Session("OperMonth")%>" MIN="<%=Html.LimitMonth(0)%>" MAX="<%=Session("OperMonth")%>" REQUIRED>
	</FIELDSET>
	<FIELDSET>
	<LEGEND>Параметри</LEGEND>
	<LABEL><INPUT TYPE="CheckBox" NAME="Filter">Часткова оплата</LABEL>
	</FIELDSET>
</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn">&#128270;Пошук</BUTTON></FORM></BODY></HTML>
