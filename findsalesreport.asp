<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Html) {
	SetHead("Звіт по продажам");
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindSalesReport" ACTION="listsalesreport.asp" METHOD="post" AUTOCOMPLETE="off">
<H3 CLASS="HeadText">Звіт по продажам</H3>
<TABLE CLASS="MarkupTable">
       	<TR><TD ALIGN="CENTER">
	<FIELDSET><LEGEND>Перioд</LEGEND>
	<INPUT TYPE="date" NAME="BegDate" VALUE="<%=Session("OperDate")%>" MIN="<%=Html.MinDate%>" MAX="<%=Session("EndDate")%>" REQUIRED> &#8722;
	<INPUT TYPE="date" NAME="EndDate" VALUE="<%=Session("EndDate")%>" MIN="<%=Html.MinDate%>" MAX="<%=Session("EndDate")%>" REQUIRED>
	</FIELDSET>
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn">&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>