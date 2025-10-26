<%@LANGUAGE="JavaScript"%>
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = User.RoleId == 1;
User.CheckAccess(Authorized, "GET");
Html.SetPage("Вартicть по ЦОС")%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindVolRem" ACTION="listvolrem.asp" METHOD="post" TARGET="_blank">
<H3 CLASS="HeadText"><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD><% Month.WritePeriod() %></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn">&#128270;Пошук</BUTTON></FORM></BODY></HTML>



