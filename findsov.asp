<%@LANGUAGE="JavaScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1,
OperMonth = Html.GetMonth(1),
MinMonth  = Html.GetMonth(0),
Title = "Сальдо-оборотна вiдомость";

if (User.ValidateAccess(Authorized, "GET")) {
	Html.SetPage(Title, User.RoleId)
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

