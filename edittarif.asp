<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1,
TarifId = Request.QueryString("TarifId");
User.ValidateAccess(Authorized, "GET");

try {
	Solaren.SetCmd("GetTarif");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("TarifId", adVarChar, adParamInput, 10, TarifId));
		}
	}
	var rs = Solaren.Execute("GetTarif", "Iнформацiю не знайдено");
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
} finally {
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
	Connect.Close();
}

var ViewOnly = !Month.isPeriod(Html.Date[0], EndDate),
Title = Deleted || ViewOnly ? "Перегляд тарифу" : "Редагування тарифу";
Html.SetPage(Title, User.RoleId)%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditTarif" ACTION="updatetarif.asp" METHOD="POST">
<INPUT TYPE="HIDDEN" NAME="TarifId" VALUE="<%=TarifId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">
<INPUT TYPE="HIDDEN" NAME="ViewOnly" VALUE="<%=ViewOnly%>">
<H3 CLASS="HeadText"><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<% Html.WriteDatePeriod("Дiє", BegDate, EndDate, Html.Date[0], Html.Date[4]) %>
	<FIELDSET><LEGEND>Ввод в експлуатацію</LEGEND>
	<INPUT TYPE="date" NAME="ExpDateBeg" VALUE="<%=ExpDateBeg%>" MIN="<%=Html.Date[0]%>" MAX="<%=Html.Date[4]%>" REQUIRED> &#8722;
	<INPUT TYPE="date" NAME="ExpDateEnd" VALUE="<%=ExpDateEnd%>" MIN="<%=Html.Date[0]%>" MAX="<%=Html.Date[4]%>" REQUIRED>
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