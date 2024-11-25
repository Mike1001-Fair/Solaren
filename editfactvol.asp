<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<% var Authorized = User.RoleId == 1,
FactVolId = Request.QueryString("FactVolId");

User.ValidateAccess(Authorized);

try {
	Solaren.SetCmd("GetFactVol");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("FactVolId", adInteger, adParamInput, 10, FactVolId));
		}
	}
	var rs = Solaren.Execute("GetFactVol", "Iнформацiю не знайдено");
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
} finally {
	with (rs) {
		var ContractId = Fields("ContractId").value,
		ContractName   = Fields("ContractName").value,
		BegDate        = Fields("BegDate").value,
		EndDate        = Fields("EndDate").value,
		RecVol         = Fields("RecVol").value,
		RetVol         = Fields("RetVol").value,
		IndicatorId    = Fields("IndicatorId").value,
		Deleted        = Fields("Deleted").value;
		Close();
	}
	Connect.Close();
}

var ViewOnly = !Month.isPeriod(Html.Date[0], EndDate) || IndicatorId != "",
Title = Deleted || ViewOnly  ? "Перегляд операції" : "Редагування операції";

Html.SetPage(Title, User.RoleId)%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditFactVol" ACTION="updatefactvol.asp" METHOD="POST">
<INPUT TYPE="HIDDEN" NAME="ContractId" ID="ContractId" VALUE="<%=ContractId%>">
<INPUT TYPE="HIDDEN" NAME="FactVolId" VALUE="<%=FactVolId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">
<INPUT TYPE="HIDDEN" NAME="IndicatorId" VALUE="<%=IndicatorId%>">
<INPUT TYPE="HIDDEN" NAME="ViewOnly" VALUE="<%=ViewOnly%>">

<H3 CLASS="HeadText"><%=Title%></H3>
<TABLE CLASS="MarkupTable">
       	<TR><TD ALIGN="CENTER">
	<% Html.WriteDatePeriod("Період", BegDate, EndDate, Html.Date[3], Html.Date[4]);
	Html.WriteSearchSet("Договір", "Contract", ContractName, 1) %> 

	<FIELDSET NAME="VolSet"><LEGEND ALIGN="CENTER">Параметри</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT">Прийом</TD>
	<TD><INPUT TYPE="Number" NAME="RecVol" VALUE="<%=RecVol%>" STEP="1" MIN="0" MAX="999999" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Видача</TD>
	<TD><INPUT TYPE="Number" NAME="RetVol" VALUE="<%=RetVol%>" STEP="1" MIN="0" MAX="999999" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT" ID="SaldoId">Сальдо</TD>
	<TD><INPUT TYPE="text" NAME="Saldo" SIZE="7" maxLength="6" READONLY></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<% if (!ViewOnly) Html.WriteEditButton(1) %>
</FORM></BODY></HTML>
