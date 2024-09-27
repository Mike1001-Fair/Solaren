<%@LANGUAGE="JavaScript"%> 
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");
with (Html) {
	SetHead("Кiлькiсть договорiв");
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindContractNumber" ACTION="listcontractnumber.asp" METHOD="post" TARGET="_blank">
<H3 CLASS="HeadText">Кiлькiсть договорiв</H3>
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<LABEL>Станом на
		<INPUT TYPE="date" NAME="ReportDate" VALUE="<%=Session("OperDate")%>" MIN="<%=Html.MinDate%>" MAX="<%=Session("EndDate")%>" REQUIRED>
	</LABEL>
	</FIELDSET>
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn">&#128270;Пошук</BUTTON></FORM></BODY></HTML>
