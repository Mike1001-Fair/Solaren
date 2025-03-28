<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = User.RoleId == 1,
Title = "Пошук операцій";
if (User.ValidateAccess(Authorized, "GET")) {
	Html.SetPage(Title)
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindOper" ACTION="listoper.asp" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="hidden" NAME="ContractId" ID="ContractId" VALUE="-1">
<H3 CLASS="HeadText"><%=Html.Title%></H3>

<TABLE CLASS="MarkupTable">
       	<TR><TD ALIGN="CENTER">
	<% with (Html) {
		WriteMonthPeriod();
		WriteSearchSet("Договір", "Contract", "", 1);
	}%></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>

