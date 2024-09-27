<%@LANGUAGE="JavaScript"%> 
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") == 1,
HeadTitle = "Вартicть по ЦОС";

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");
with (Html) {
	SetHead(HeadTitle);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindVolRem" ACTION="listvolrem.asp" METHOD="post" TARGET="_blank">
<H3 CLASS="HeadText"><%=HeadTitle%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD><% Html.WriteMonthPeriod() %></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn">&#128270;Пошук</BUTTON></FORM></BODY></HTML>
