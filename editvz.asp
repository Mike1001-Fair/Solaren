<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2,
VzId = Request.QueryString("VzId");

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

try {
	Solaren.SetCmd("GetVz");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("VzId", adInteger, adParamInput, 10, VzId));
		}
	}
	var rs = Cmd.Execute();
	with (rs) {
		var BegDate = Fields("BegDate").value,
		EndDate     = Fields("EndDate").value,
		VzTax       = Fields("VzTax").value,
		Deleted     = Fields("Deleted").value,
		HeadTitle   = Deleted ? "Перегляд ставки ВЗ" : "Редагування ставки ВЗ";
		Close();
	} Connect.Close();
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

with (Html) {
	SetHead(HeadTitle);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditVz" ACTION="updatevz.asp" METHOD="POST">
<INPUT TYPE="HIDDEN" NAME="VzId" VALUE="<%=VzId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">

<H3 CLASS="HeadText"><%=HeadTitle%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<% Html.WriteDatePeriod("Період", BegDate, EndDate, Html.MinDate, Html.MaxDate) %>
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<LABEL>Ставка
	<INPUT TYPE="Number" NAME="VzTax" VALUE="<%=VzTax%>" STEP="0.1" MIN="0" MAX="99" PLACEHOLDER="%" REQUIRED></LABEL>
	</FIELDSET></TD></TR>
</TABLE>
<% Html.WriteEditButton(1)%>
</FORM></BODY></HTML>