<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = User.RoleId == 1;
if (User.ValidateAccess(Authorized, "GET")) {
	Html.SetPage("Нова ставка ПДФО")
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewPdfo" ACTION="createpdfo.asp" METHOD="POST">
<H3 CLASS="HeadText"><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<% Html.WriteDatePeriod("Період", Month.Date[1], Month.Date[2], Month.Date[0], Month.Date[4]) %>
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<LABEL>Ставка
	<INPUT TYPE="Number" NAME="PdfoTax" STEP="0.1" MIN="0" MAX="99" PLACEHOLDER="%" REQUIRED></LABEL>
	</FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>Створити</BUTTON></FORM></BODY></HTML>
