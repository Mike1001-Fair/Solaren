<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Html) {
	SetHead("Нова ставка ВЗ");
	WriteScript();
	Menu.Write(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewVz" ACTION="createvz.asp" METHOD="POST">
<H3 CLASS="HeadText">Нова ставка ВЗ</H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<% Html.WriteDatePeriod("Період", Month.Date[1], Month.Date[2], Month.Date[0], Month.Date[4]) %>
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<LABEL>Ставка
	<INPUT TYPE="Number" NAME="VzTax" STEP="0.1" MIN="0" MAX="99" PLACEHOLDER="%" REQUIRED></LABEL>
	</FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>Створити</BUTTON></FORM></BODY></HTML>