<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = Session("RoleId") == 1,
PayId = Request.QueryString("PayId");
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

try {
	Solaren.SetCmd("GetPay");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("PayId", adInteger, adParamInput, 10, PayId));
		}
	}
	var rsPay = Cmd.Execute();
	with (rsPay) {
		var ContractId = Fields("ContractId").value,
		ContractName   = Fields("ContractName").value,
		PayDate        = Fields("PayDate").value,
		PaySum         = Fields("PaySum").value,
		Deleted        = Fields("Deleted").value;
		Close();
	}
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
} finally {	
	Connect.Close();
}

var ViewOnly = !Month.isPeriod(Session("OperDate"), PayDate),
HeadTitle    = Deleted || ViewOnly ? "Перегляд оплати" : "Редагування оплати";

with (Html) {
	SetHead(HeadTitle);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditPay" ACTION="updatepay.asp" METHOD="post">
<H3 CLASS="HeadText" ID="H3Id"><BIG>&#128182;</BIG><%=HeadTitle%></H3>
<INPUT TYPE="HIDDEN" NAME="ContractId" ID="ContractId" VALUE="<%=ContractId%>">
<INPUT TYPE="HIDDEN" NAME="PayId" VALUE="<%=PayId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">
<INPUT TYPE="HIDDEN" NAME="ViewOnly" VALUE="<%=ViewOnly%>">
<TABLE CLASS="MarkupTable">
       	<TR><TD ALIGN="CENTER">
	<% Html.WriteContractName(ContractName, "REQUIRED") %>
	<FIELDSET NAME="PaySet"><LEGEND>Параметри</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT">Дата</TD>
	<TD><INPUT TYPE="date" NAME="PayDate" VALUE="<%=PayDate%>" MIN="<%=Session("OperDate")%>" MAX="<%=Session("EndDate")%>" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">Сума</TD>
	<TD><INPUT TYPE="Number" NAME="PaySum" VALUE="<%=PaySum%>" STEP="0.01" MIN="0" MAX="999999999" REQUIRED AUTOFOCUS></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<% if (!ViewOnly) Html.WriteEditButton(1) %>
</FORM></BODY></HTML>