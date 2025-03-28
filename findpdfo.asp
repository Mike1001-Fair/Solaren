<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = User.RoleId == 1;
if (User.ValidateAccess(Authorized, "GET")) {
	Html.SetPage("Cтавка ПДФО")
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindPdfo" ACTION="listpdfo.asp" METHOD="post">
<H3 CLASS="HeadText"><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<% Html.WriteDate() %>
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn">&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>
