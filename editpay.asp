<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1,
Query = Solaren.Parse();

User.ValidateAccess(Authorized, "GET");
try {
	Solaren.SetCmd("GetPay");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("PayId", adInteger, adParamInput, 10, Query.PayId));
		}
	}
	var rs = Solaren.Execute("GetPay");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	var Payment = Solaren.Map(rs.Fields),
	ViewOnly = !Month.isPeriod(Month.Date[1], Payment.PayDate),
	Title = Payment.Deleted || ViewOnly ? "Перегляд оплати" : "Редагування оплати";
	rs.Close();
	Solaren.Close();
	Html.SetPage(Title);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditPay" ACTION="updatepay.asp" METHOD="post">
<H3 CLASS="HeadText" ID="H3Id"><BIG>&#128182;</BIG><%=Html.Title%></H3>
<INPUT TYPE="HIDDEN" NAME="ContractId" ID="ContractId" VALUE="<%=Payment.ContractId%>">
<INPUT TYPE="HIDDEN" NAME="PayId" VALUE="<%=Query.PayId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Payment.Deleted%>">
<INPUT TYPE="HIDDEN" NAME="ViewOnly" VALUE="<%=ViewOnly%>">
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<% Html.WriteSearchSet("Договір", "Contract", Payment.ContractName, 1) %>
	<FIELDSET NAME="PaySet"><LEGEND>Параметри</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT">Дата</TD>
	<TD><INPUT TYPE="date" NAME="PayDate" VALUE="<%=Payment.PayDate%>" MIN="<%=Month.Date[1]%>" MAX="<%=Month.Date[2]%>" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Сума</TD>
	<TD><INPUT TYPE="Number" NAME="PaySum" VALUE="<%=Payment.PaySum%>" STEP="0.01" MIN="0" MAX="999999999" REQUIRED AUTOFOCUS></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<% if (!ViewOnly) {
	Html.WriteEditButton(1, Payment.Deleted)
}%>
</FORM></BODY></HTML>