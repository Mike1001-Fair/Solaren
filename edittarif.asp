<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = Session("RoleId") == 1,
TarifId = Request.QueryString("TarifId");

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

try {
	Solaren.SetCmd("GetTarif");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("TarifId", adVarChar, adParamInput, 10, TarifId));
		}
	}
	var rs = Cmd.Execute();
	Solaren.EOF(rs, 'Тариф не знайдено!');
	with (rs) {
		var GroupId = Fields("GroupId").value,
		BegDate     = Fields("BegDate").value,
		EndDate     = Fields("EndDate").value,
		ExpDateBeg  = Fields("ExpDateBeg").value,
		ExpDateEnd  = Fields("ExpDateEnd").value,
		Tarif       = Fields("Tarif").value,
		Deleted     = Fields("Deleted").value;
		Close();
	}
}
catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
} finally {
	Connect.Close();
}

var ViewOnly = !Month.isPeriod(Session("OperDate"), EndDate),
HeadTitle    = Deleted || ViewOnly ? "Перегляд тарифу" : "Редагування тарифу";
with (Html) {
	SetHead(HeadTitle);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditTarif" ACTION="updatetarif.asp" METHOD="POST">
<INPUT TYPE="HIDDEN" NAME="TarifId" VALUE="<%=TarifId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">
<INPUT TYPE="HIDDEN" NAME="ViewOnly" VALUE="<%=ViewOnly%>">
<H3 CLASS="HeadText"><%=HeadTitle%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<% Html.WriteDatePeriod("Дiє", BegDate, EndDate, Html.MinDate, Html.MaxDate) %>
	<FIELDSET><LEGEND>Ввод в експлуатацію</LEGEND>
	<INPUT TYPE="date" NAME="ExpDateBeg" VALUE="<%=ExpDateBeg%>" MIN="<%=Html.MinDate%>" MAX="<%=Html.MaxDate%>" REQUIRED> &#8722;
	<INPUT TYPE="date" NAME="ExpDateEnd" VALUE="<%=ExpDateEnd%>" MIN="<%=Html.MinDate%>" MAX="<%=Html.MaxDate%>" REQUIRED>
	</FIELDSET>

	<FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Група</TD>
	<TD><%Html.WriteTarif("GroupId", GroupId)%></TD></TR>

	<TR><TD ALIGN="RIGHT">Тариф</TD>
	<TD><INPUT TYPE="Number" NAME="Tarif" VALUE="<%=Tarif%>" STEP="0.01" MIN="0" MAX="999999" REQUIRED TITLE="коп"></TD></TR>
	</TABLE></FIELDSET>
	</TD></TR>
</TABLE>
<% if (!ViewOnly) Html.WriteEditButton(1) %>
</FORM></BODY></HTML>