<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/new.set" -->
<% var Authorized = User.RoleId == 1,
Items = ["Контрагенти", "Нарахування", "До сплати"],
OperMonth = Month.GetMonth(1);

if (User.CheckAccess(Authorized, "GET")) {
	Html.SetPage("Eкспорт")
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewExport" ACTION="create1cagent.asp" METHOD="post">
<INPUT TYPE="HIDDEN" NAME="ReportCharSet">

<H3 CLASS="HeadText"><IMG SRC="Images/export.png"><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD><FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT">Перioд</TD>
	<TD><INPUT TYPE="Month" NAME="OperMonth" VALUE="<%=OperMonth%>" MAX="<%=OperMonth%>" READONLY></TD></TR>

	<TR><TD ALIGN="RIGHT">Файл</TD>
	<TD><%=Html.WriteList("FileType", Items)%></TD></TR>

	<TR><TD ALIGN="RIGHT">Кодування</TD>
	<TD><%=CodePage.Write()%></TD></TR>

	</TABLE></FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn">Створити</BUTTON></FORM></BODY></HTML>



