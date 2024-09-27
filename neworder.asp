<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") < 2;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");
with (Html) {
	SetHead("Нове замовлення");
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewOrder" ID="NewOrder" ACTION="createorder.asp" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="hidden" NAME="ContractId" ID="ContractId" VALUE="-1">
<INPUT TYPE="HIDDEN" NAME="JsonData">
<H3 CLASS="HeadText">🛒Нове замовлення</H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<FIELDSET><LEGEND>Дата</LEGEND>
		<INPUT TYPE="date" NAME="OrderDate" VALUE="<%=Session("OperDate")%>" MIN="<%=Session("OperDate")%>" MAX="<%=Session("EndDate")%>" REQUIRED>
	</FIELDSET>
	<% Html.WriteContractName("", "REQUIRED") %>
	<FIELDSET><LEGEND><BUTTON TYPE="button" CLASS="AddBtn" ID="AddBtn" TITLE="Додати">&#x2795;Список</BUTTON></LEGEND>
	<TABLE ID="OrderItemsTable">
		<TBODY></TBODY>
	</TABLE></FIELDSET>
	<FIELDSET><LEGEND>Всього</LEGEND>
	<TABLE>
		<TR><TD>Кількість</TD>
		<TD><INPUT type="text" ID="total" SIZE="5" READONLY></TD>
	</TABLE></FIELDSET>
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>Створити</BUTTON>
</FORM></BODY></HTML>