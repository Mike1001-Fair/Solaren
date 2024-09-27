<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
	var OrderId = QueryString("OrderId");
}

try {
	Solaren.SetCmd("GetOrder");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("OrderId", adInteger, adParamInput, 10, OrderId));
		}
	}
	var rsOrder = Cmd.Execute();
	with (rsOrder) {
	    var ContractId   = Fields("ContractId").value,
		ContractName = Fields("ContractName").value,
		OrderDate    = Fields("OrderDate").value,
		JsonData     = Fields("JsonData").value,
		Deleted      = Fields("Deleted").value;
		Close();
	}
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

var ViewOnly = !Month.isPeriod(Session("OperDate"), OrderDate),
HeadTitle    = Deleted || ViewOnly ? "Перегляд замовлення" : "Редагування замовлення";

with (Html) {
	SetHead(HeadTitle);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditOrder" ACTION="updateorder.asp" METHOD="post">
<H3 CLASS="HeadText" ID="H3Id">🛒<%=HeadTitle%></H3>
<INPUT TYPE="hidden" NAME="ContractId" ID="ContractId" VALUE="<%=ContractId%>">
<INPUT TYPE="HIDDEN" NAME="OrderId" VALUE="<%=OrderId%>">
<INPUT TYPE="HIDDEN" NAME="JsonData" VALUE='<%=JsonData%>'>
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">
<INPUT TYPE="HIDDEN" NAME="ViewOnly" VALUE="<%=ViewOnly%>">
<TABLE CLASS="MarkupTable">
       	<TR><TD ALIGN="CENTER">
	<% Html.WriteContractName(ContractName, "REQUIRED") %>
	<FIELDSET NAME="OrderSet"><LEGEND>Параметри</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT">Дата</TD>
	<TD><INPUT TYPE="date" NAME="OrderDate" VALUE="<%=OrderDate%>" MIN="<%=Session("OperDate")%>" MAX="<%=Session("EndDate")%>" REQUIRED></TD></TR>
	</TABLE></FIELDSET>
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
<% if (!ViewOnly) Html.WriteEditButton(1) %>
</FORM></BODY></HTML>