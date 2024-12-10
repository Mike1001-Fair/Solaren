<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 2,
Title = "Друк акту";
User.ValidateAccess(Authorized, "GET");
Html.SetPage(Title, User.RoleId)%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindAct" ACTION="prnact.asp" TARGET="_blank" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="hidden" NAME="ContractId" ID="ContractId" VALUE="-1">
<H3 CLASS="HeadText"><IMG CLASS="H3Img" SRC="Images/printer.svg"><%=Html.Title%></H3>

<TABLE CLASS="MarkupTable">
       	<TR><TD ALIGN="CENTER">
	<% Html.WriteSearchSet("Договір", "Contract", "", 1) %>
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE>
	<TR><TD><LABEL CLASS="BlockLabel" FOR="ReportMonth">Перioд:</LABEL>
	<INPUT TYPE="Month" NAME="ReportMonth" ID="ReportMonth" VALUE="<%=Html.GetMonth(1)%>" MIN="<%=Html.GetMonth(1)%>" MAX="<%=Html.GetMonth(1)%>" REQUIRED></TD>
	<TD><LABEL><INPUT TYPE="CheckBox" NAME="DoubleAct" CHECKED>2 копії</LABEL>	
	<LABEL CLASS="BlockLabel"><INPUT TYPE="CheckBox" NAME="AllContract">Всi договора</LABEL></TD></TR>
	</TABLE>
	</FIELDSET>
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>
