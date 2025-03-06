<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = User.RoleId == 2,
Title = "Звiт про показники";
User.ValidateAccess(Authorized, "GET");
Html.SetPage(Title, User.RoleId)%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindIndicatorRep" ACTION="prnindicatorrep.asp" TARGET="_blank" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="hidden" NAME="ContractId" ID="ContractId" VALUE="-1">
<H3 CLASS="HeadText"><IMG CLASS="H3Img" SRC="Images/printer.svg"><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<% Html.WriteSearchSet("Договір", "Contract", "", 1) %>
	<FIELDSET ALIGN="CENTER"><LEGEND>Параметри</LEGEND>
	<INPUT TYPE="Month" NAME="ReportMonth" VALUE="<%=Month.GetMonth(1)%>" MIN="<%=Month.GetMonth(0)%>" MAX="<%=Month.GetMonth(1)%>" REQUIRED>
	<LABEL><INPUT TYPE="CheckBox" NAME="DoubleReport" CHECKED>2 копії</LABEL>
	</FIELDSET>
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>&#128270;Пошук</BUTTON></DIV>
</FORM></BODY></HTML>

