<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 2,
Title = "Звiт про показники";
User.ValidateAccess(Authorized, "GET");
Html.SetPage(Title, User.RoleId)%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindIndicatorRep" ACTION="prnindicatorrep.asp" TARGET="_blank" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="hidden" NAME="ContractId" ID="ContractId" VALUE="-1">
<H3 CLASS="HeadText"><IMG CLASS="H3Img" SRC="Images/printer.svg"><%=Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<% Html.WriteSearchSet("Договір", "Contract", "", 1) %>
	<FIELDSET ALIGN="CENTER"><LEGEND>Параметри</LEGEND>
	<INPUT TYPE="Month" NAME="ReportMonth" VALUE="<%=Html.GetMonth(1)%>" MIN="<%=Html.GetMonth(1)%>" MAX="<%=Html.GetMonth(1)%>" REQUIRED>
	<LABEL><INPUT TYPE="CheckBox" NAME="DoubleReport" CHECKED>2 копії</LABEL>
	</FIELDSET>
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>&#128270;Пошук</BUTTON></DIV>
</FORM></BODY></HTML>
