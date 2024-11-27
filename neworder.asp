<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1,
Title = "Нове замовлення";

if (User.ValidateAccess(Authorized)) {
	Html.SetPage(Title, User.RoleId)
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewOrder" ID="NewOrder" ACTION="createorder.asp" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="hidden" NAME="ContractId" ID="ContractId" VALUE="-1">
<INPUT TYPE="HIDDEN" NAME="JsonData">
<H3 CLASS="HeadText">🛒Нове замовлення</H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<FIELDSET><LEGEND>Дата</LEGEND>
		<INPUT TYPE="date" NAME="OrderDate" VALUE="<%=Html.OperDate%>" MIN="<%=Html.OperDate%>" MAX="<%=Html.EndDate%>" REQUIRED>
	</FIELDSET>
	<% Html.WriteSearchSet("Договір", "Contract", "", 1); %>
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
