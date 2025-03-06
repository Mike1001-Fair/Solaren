<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1,
FactVolId = Request.QueryString("FactVolId");

User.ValidateAccess(Authorized, "GET");

try {
	Solaren.SetCmd("GetOper");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("FactVolId", adInteger, adParamInput, 10, FactVolId));
		}
	}
	var rs = Solaren.Execute("GetOper", "Iнформацiю не знайдено");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	with (rs) {
		var ContractId = Fields("ContractId").value,
		ContractName   = Fields("ContractName").value,
		BegDate        = Fields("BegDate").value,
		EndDate        = Fields("EndDate").value,
		RetVol         = Fields("RetVol").value,
		VolCost        = Fields("VolCost").value,
		IndicatorId    = Fields("IndicatorId").value,
		Deleted        = Fields("Deleted").value;
		Close();
	}
	Connect.Close();
}

var ViewOnly = !Month.isPeriod(Month.Date[0], EndDate) || IndicatorId != "",
Title = Deleted || ViewOnly  ? "Перегляд операції" : "Редагування операції";

Html.SetPage(Title, User.RoleId)%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditOper" ACTION="updateoper.asp" METHOD="POST">
<INPUT TYPE="HIDDEN" NAME="FactVolId" VALUE="<%=FactVolId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">
<INPUT TYPE="HIDDEN" NAME="ViewOnly" VALUE="<%=ViewOnly%>">

<H3 CLASS="HeadText"><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
       	<TR><TD ALIGN="CENTER">
	<% Html.WriteDatePeriod("Період", BegDate, EndDate, Month.Date[3], Month.Date[4]);
	Html.WriteSearchSet("Договір", "Contract", ContractName, 1) %> 

	<FIELDSET NAME="OperSet"><LEGEND ALIGN="CENTER">Параметри</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT">Видача</TD>
	<TD><INPUT TYPE="Number" NAME="RetVol" VALUE="<%=RetVol%>" STEP="1" MIN="0" MAX="999999" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">Вартість</TD>
	<TD><INPUT TYPE="Number" NAME="VolCost" VALUE="<%=VolCost%>" STEP="0.01" MIN="0" MAX="99999999" REQUIRED></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<% if (!ViewOnly) Html.WriteEditButton(1) %>
</FORM></BODY></HTML>
