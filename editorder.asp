<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE VIRTUAL="Solaren/Set/edit.set" -->
<% var Authorized = User.RoleId == 1,
OrderId = Request.QueryString("OrderId");
User.CheckAccess(Authorized, "GET");

try {
	Db.SetCmd("GetOrder");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("OrderId", adInteger, adParamInput, 10, OrderId));
		}
	}
	var rsOrder = Cmd.Execute();
	with (rsOrder) {
	    var ContractId   = Fields("ContractId").Value,
		ContractName = Fields("ContractName").Value,
		OrderDate    = Fields("OrderDate").Value,
		JsonData     = Fields("JsonData").Value,
		Deleted      = Fields("Deleted").Value;
		Close();
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}

var ViewOnly = !Month.isPeriod(Month.Date[0], OrderDate),
Title = Deleted || ViewOnly ? "Перегляд замовлення" : "Редагування замовлення";
Html.SetPage(Title)%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditOrder" ACTION="updateorder.asp" METHOD="post">
<H3 CLASS="HeadText" ID="H3Id">🛒<%=Html.Title%></H3>
<INPUT TYPE="hidden" NAME="ContractId" ID="ContractId" VALUE="<%=ContractId%>">
<INPUT TYPE="HIDDEN" NAME="OrderId" VALUE="<%=OrderId%>">
<INPUT TYPE="HIDDEN" NAME="JsonData" VALUE='<%=JsonData%>'>
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">
<INPUT TYPE="HIDDEN" NAME="ViewOnly" VALUE="<%=ViewOnly%>">
<TABLE CLASS="MarkupTable">
       	<TR><TD ALIGN="CENTER">
	<% Html.WriteSearchSet("Договір", "Contract", ContractName, 1) %> 
	<FIELDSET NAME="OrderSet"><LEGEND>Параметри</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT">Дата</TD>
	<TD><INPUT TYPE="date" NAME="OrderDate" VALUE="<%=OrderDate%>" MIN="<%=Month.Date[1]%>" MAX="<%=Month.Date[2]%>" REQUIRED></TD></TR>
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