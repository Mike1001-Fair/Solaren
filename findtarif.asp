<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/find.set" -->
<% var Authorized = User.RoleId == 1;
if (User.CheckAccess(Authorized, "GET")) {
	Html.SetPage("Тариф")
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindTarif" ACTION="listtarif.asp" METHOD="post">
<INPUT TYPE="HIDDEN" NAME="GroupName">
<H3 CLASS="HeadText"><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<% Month.WriteDate();
	Tarif.WriteGroup();
	%></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn">&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>


