<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") == 2,
Title = "Друк акту";

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Html) {
	SetHead(Title);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindAct" ACTION="prnact.asp" TARGET="_blank" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="hidden" NAME="ContractId" ID="ContractId" VALUE="-1">
<H3 CLASS="HeadText"><IMG CLASS="H3Img" SRC="Images/printer.svg"><%=Title%></H3>

<TABLE CLASS="MarkupTable">
       	<TR><TD ALIGN="CENTER">
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE>
	<TR><TD><LABEL CLASS="BlockLabel" FOR="ReportMonth">Перioд:</LABEL>
	<INPUT TYPE="Month" NAME="ReportMonth" ID="ReportMonth" VALUE="<%=Session("OperMonth")%>" MIN="<%=Html.LimitMonth(0)%>" MAX="<%=Session("OperMonth")%>" REQUIRED></TD>
	<TD><LABEL><INPUT TYPE="CheckBox" NAME="DoubleAct" CHECKED>2 копії</LABEL>	
	<LABEL CLASS="BlockLabel"><INPUT TYPE="CheckBox" NAME="AllContract">Всi договора</LABEL></TD></TR>
	</TABLE>
	</FIELDSET>
	<% Html.WriteContractName("", "REQUIRED") %>
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>