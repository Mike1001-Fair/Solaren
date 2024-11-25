<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2,
PdfoId = Request.QueryString("PdfoId");

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

try {
	Solaren.SetCmd("GetPdfo");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("PdfoId", adInteger, adParamInput, 10, PdfoId));
		}
	}
	var rs = Cmd.Execute();
	with (rs) {
		var BegDate = Fields("BegDate").value,
		EndDate     = Fields("EndDate").value,
		PdfoTax     = Fields("PdfoTax").value,
		Deleted     = Fields("Deleted").value,
		HeadTitle   = Deleted ? "Перегляд ставки пдфо" : "Редагування ставки пдфо";
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
<FORM CLASS="ValidForm" NAME="EditPdfo" ACTION="updatepdfo.asp" METHOD="POST">
<INPUT TYPE="HIDDEN" NAME="PdfoId" VALUE="<%=PdfoId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">

<H3 CLASS="HeadText"><%=HeadTitle%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<% Html.WriteDatePeriod("Період", BegDate, EndDate, Html.Date[0], Html.Date[4]) %>
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<LABEL>Ставка
	<INPUT TYPE="Number" NAME="PdfoTax" VALUE="<%=PdfoTax%>" STEP="0.1" MIN="0" MAX="99" PLACEHOLDER="%" REQUIRED></LABEL>
	</FIELDSET></TD></TR>
</TABLE>
<% Html.WriteEditButton(1)%>
</FORM></BODY></HTML>