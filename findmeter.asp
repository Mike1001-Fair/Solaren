<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1;
if (User.ValidateAccess(Authorized, "GET")) {
	Html.SetPage("Лiчильники")
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindMeter" ID="FindMeter" ACTION="listmeter.asp" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="hidden" NAME="ContractId" ID="ContractId" VALUE="-1">
<H3 CLASS="HeadText"><IMG SRC="Images/MeterIcon.svg"><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<% Html.WriteSearchSet("Договір", "Contract", "", 0) %>
	<FIELDSET><LEGEND>Номер</LEGEND>
	<INPUT TYPE="search" NAME="MeterCode" SIZE="15" MAXLENGTH="10">
	</FIELDSET>
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>&#128270;Пошук</BUTTON>
</FORM></HTML></BODY>
