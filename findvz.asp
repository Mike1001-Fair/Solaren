<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/find.set" -->
<% var Authorized = User.RoleId == 1;
if (User.CheckAccess(Authorized, "GET")) {
	Html.SetPage("Cтавка ВЗ")
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindPdfo" ACTION="listvz.asp" METHOD="post">
<H3 CLASS="HeadText"><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<% Month.WriteDate() %>
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn">&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>


