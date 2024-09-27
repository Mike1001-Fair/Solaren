<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Html) {
	SetHead("Нова оплата");
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewPay" ACTION="createpay.asp" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="hidden" NAME="ContractId" ID="ContractId" VALUE="-1">
<H3 CLASS="HeadText"><BIG>&#128182;</BIG>Нова оплата</H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<% Html.WriteContractName("", "REQUIRED") %>
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT">Дата</TD>
	<TD><INPUT TYPE="date" NAME="PayDate" VALUE="<%=Session("OperDate")%>" MIN="<%=Session("OperDate")%>" MAX="<%=Session("EndDate")%>" REQUIRED></TD></TR>
	
	<TR><TD ALIGN="RIGHT">Сума</TD>
	<TD><INPUT TYPE="Number" NAME="PaySum" STEP="0.01" MIN="0" MAX="999999999" REQUIRED></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" DISABLED>Створити</BUTTON>
</FORM></BODY></HTML>