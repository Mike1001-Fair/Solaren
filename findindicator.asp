<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId > 0 && User.RoleId < 3,
Title = "Показники";

User.ValidateAccess(Authorized, "GET");
Html.SetPage(Title, User.RoleId)%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindIndicator" ID="FindIndicator" ACTION="listindicator.asp" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="hidden" NAME="ContractId" ID="ContractId" VALUE="-1">

<H3 CLASS="HeadText"><IMG SRC="Images/MeterIcon.svg"><%=Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<% with (Html) {
		WriteDatePeriod("Період", Date[1], Date[2], Date[0], Date[3]);
		WriteSearchSet("Договір", "Contract", "", 1);
	}%>
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>

