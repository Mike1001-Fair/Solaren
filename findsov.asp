<%@LANGUAGE="JavaScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = User.RoleId == 1,
OperMonth = Month.GetMonth(1),
MinMonth  = Month.GetMonth(0);

if (User.CheckAccess(Authorized, "GET")) {
	Html.SetPage("Сальдо-оборотна вiдомость")
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindSov" ACTION="listsov.asp" METHOD="post" TARGET="_blank">
<H3 CLASS="HeadText"><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET>
		<LEGEND>Перiод</LEGEND>
		<INPUT TYPE="Month" NAME="ReportMonth" VALUE="<%=OperMonth%>" MIN="<%=MinMonth%>" MAX="<%=OperMonth%>" REQUIRED>
	</FIELDSET>
	<FIELDSET>
		<LEGEND>Параметри</LEGEND>
		<LABEL><INPUT TYPE="CheckBox" NAME="Filter">Часткова оплата</LABEL>
	</FIELDSET>
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn">&#128270;Пошук</BUTTON></FORM></BODY></HTML>




