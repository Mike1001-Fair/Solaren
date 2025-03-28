<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1,
PayId = Request.QueryString("PayId");

User.ValidateAccess(Authorized, "GET");
try {
	Solaren.SetCmd("GetPay");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("PayId", adInteger, adParamInput, 10, PayId));
		}
	}
	var rs = Solaren.Execute("GetPay");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	with (rs) {
		var ContractId = Fields("ContractId").value,
		ContractName   = Fields("ContractName").value,
		PayDate        = Fields("PayDate").value,
		PaySum         = Fields("PaySum").value,
		Deleted        = Fields("Deleted").value;
		Close();
	}
	Solaren.Close();
}

var ViewOnly = !Month.isPeriod(Month.Date[1], PayDate),
Title = Deleted || ViewOnly ? "Перегляд оплати" : "Редагування оплати";
Html.SetPage(Title)%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditPay" ACTION="updatepay.asp" METHOD="post">
<H3 CLASS="HeadText" ID="H3Id"><BIG>&#128182;</BIG><%=Html.Title%></H3>
<INPUT TYPE="HIDDEN" NAME="ContractId" ID="ContractId" VALUE="<%=ContractId%>">
<INPUT TYPE="HIDDEN" NAME="PayId" VALUE="<%=PayId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">
<INPUT TYPE="HIDDEN" NAME="ViewOnly" VALUE="<%=ViewOnly%>">
<TABLE CLASS="MarkupTable">
       	<TR><TD ALIGN="CENTER">
	<% Html.WriteSearchSet("Договір", "Contract", ContractName, 1) %>
	<FIELDSET NAME="PaySet"><LEGEND>Параметри</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT">Дата</TD>
	<TD><INPUT TYPE="date" NAME="PayDate" VALUE="<%=PayDate%>" MIN="<%=Month.Date[1]%>" MAX="<%=Month.Date[2]%>" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">Сума</TD>
	<TD><INPUT TYPE="Number" NAME="PaySum" VALUE="<%=PaySum%>" STEP="0.01" MIN="0" MAX="999999999" REQUIRED AUTOFOCUS></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<% if (!ViewOnly) Html.WriteEditButton(1) %>
</FORM></BODY></HTML>

