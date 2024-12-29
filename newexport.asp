<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = Session("RoleId") == 1,
OperMonth = Month.GetMonth(1);

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Html) {
	SetHead("Файл експорту");
	WriteScript();
	Menu.Write(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewExport" ACTION="create1cagent.asp" METHOD="post">
<INPUT TYPE="HIDDEN" NAME="ReportCharSet">

<H3 CLASS="HeadText"><IMG SRC="Images/export.png">Eкспорт</H3>
<TABLE CLASS="MarkupTable">
	<TR><TD><FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT">Перioд</TD>
	<TD><INPUT TYPE="Month" NAME="OperMonth" VALUE="<%=OperMonth%>" MAX="<%=OperMonth%>" READONLY></TD></TR>

	<TR><TD ALIGN="RIGHT">Файл</TD>
	<TD><SELECT NAME="FileType">
	<OPTION VALUE="0">Контрагенти</OPTION>
	<OPTION VALUE="1">Нарахування</OPTION>
	<OPTION VALUE="2">До сплати</OPTION>
	</SELECT></TD></TR>

	<TR><TD ALIGN="RIGHT">Кодування</TD>
	<TD><%=Html.WriteCodePage()%></TD></TR>

	</TABLE></FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn">Створити</BUTTON></FORM></BODY></HTML>
