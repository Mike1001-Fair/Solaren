<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") == 2,
Title = "Звiт про показники";

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Html) {
	SetHead(Title);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindIndicatorRep" ACTION="prnindicatorrep.asp" TARGET="_blank" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="hidden" NAME="ContractId" ID="ContractId" VALUE="-1">
<H3 CLASS="HeadText"><IMG CLASS="H3Img" SRC="Images/printer.svg"><%=Title%></H3>
<!--H3 CLASS="HeadText"><SPAN CLASS="PrinterIcon">&#128424;</SPAN>Звiт про показники лiчильника</H3-->
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET ALIGN="CENTER"><LEGEND>Параметри</LEGEND>
	<INPUT TYPE="Month" NAME="ReportMonth" VALUE="<%=Session("OperMonth")%>" MIN="<%=Html.LimitMonth(0)%>" MAX="<%=Session("OperMonth")%>" REQUIRED>
	<LABEL><INPUT TYPE="CheckBox" NAME="DoubleReport" CHECKED>2 копії</LABEL>
	</FIELDSET>
	<% Html.WriteContractName("", "REQUIRED") %>
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>&#128270;Пошук</BUTTON></DIV>
</FORM></BODY></HTML>