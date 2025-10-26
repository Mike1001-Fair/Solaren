<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1;
if (User.CheckAccess(Authorized, "GET")) {
	Html.SetPage("Договора")
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindContract" ID="FindContract" ACTION="listcontract.asp" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="hidden" NAME="CustomerId" ID="CustomerId" VALUE="-1">
<H3 CLASS="HeadText"><BIG>&#128214;</BIG><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<% Html.WriteSearchSet("Споживач", "Customer", "", 0)%>
	<FIELDSET><LEGEND>Рахунок</LEGEND>
	<INPUT TYPE="TEXT" TYPE="search" NAME="PAN" SIZE="10" MAXLENGTH="9">	
	</FIELDSET>
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>



