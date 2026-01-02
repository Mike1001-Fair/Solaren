<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/find.set" -->
<% var Authorized = User.RoleId == 1;
if (User.CheckAccess(Authorized, "GET")) {
	Html.SetPage("Cпоживачі")
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindCustomer" ID="FindCustomer" ACTION="editcustomer.asp" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="hidden" NAME="CustomerId" ID="CustomerId" VALUE="-1">
<H3 CLASS="HeadText"><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER"><% Html.WriteSearchSet("Споживач", "Customer", "", 1)%></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>



