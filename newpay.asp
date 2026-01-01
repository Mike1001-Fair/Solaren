<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE VIRTUAL="Solaren/Include/new.inc" -->
<% var Authorized = User.RoleId == 1;
if (User.CheckAccess(Authorized, "GET")) {
	Html.SetPage("Нова оплата")
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewPay" ACTION="createpay.asp" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="hidden" NAME="ContractId" ID="ContractId" VALUE="-1">
<H3 CLASS="HeadText"><BIG>&#128182;</BIG><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<% Html.WriteSearchSet("Договір", "Contract", "", 1) %>
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT">Дата</TD>
	<TD><INPUT TYPE="date" NAME="PayDate" VALUE="<%=Month.Date[1]%>" MIN="<%=Month.Date[1]%>" MAX="<%=Month.Date[2]%>" REQUIRED></TD></TR>
	
	<TR><TD ALIGN="RIGHT">Сума</TD>
	<TD><INPUT TYPE="Number" NAME="PaySum" STEP="0.01" MIN="0" MAX="999999999" REQUIRED></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" DISABLED>Створити</BUTTON>
</FORM></BODY></HTML>



