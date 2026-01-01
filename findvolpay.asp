<%@LANGUAGE="JavaScript"%>
<!-- #INCLUDE VIRTUAL="Solaren/Include/find.inc" -->
<% var Authorized = User.RoleId == 1;
if (User.CheckAccess(Authorized, "GET")) {
	Html.SetPage("Енергозбереження")
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindVolPay" ACTION="listvolpay.asp" METHOD="post" TARGET="_blank">
<H3 CLASS="HeadText"><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
<TR><TD><%Month.WritePeriod()%></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn">&#128270;Пошук</BUTTON></FORM></BODY></HTML>


