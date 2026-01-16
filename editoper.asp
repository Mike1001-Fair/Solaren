<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE VIRTUAL="Solaren/Set/edit.set" -->
<% var Authorized = User.RoleId == 1,
FactVolId = Request.QueryString("FactVolId");

User.CheckAccess(Authorized, "GET");

try {
	Db.SetCmd("GetOper");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("FactVolId", adInteger, adParamInput, 10, FactVolId));
		}
	}
	var rs = Db.Execute("GetOper");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	with (rs) {
		var ContractId = Fields("ContractId").Value,
		ContractName   = Fields("ContractName").Value,
		BegDate        = Fields("BegDate").Value,
		EndDate        = Fields("EndDate").Value,
		RetVol         = Fields("RetVol").Value,
		VolCost        = Fields("VolCost").Value,
		IndicatorId    = Fields("IndicatorId").Value,
		Deleted        = Fields("Deleted").Value;
		Close();
	}
	Db.Close();
}

var ViewOnly = !Month.isPeriod(Month.Date[0], EndDate) || IndicatorId != "",
Title = Deleted || ViewOnly  ? "Перегляд операції" : "Редагування операції";

Html.SetPage(Title)%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditOper" ACTION="updateoper.asp" METHOD="POST">
<INPUT TYPE="HIDDEN" NAME="FactVolId" VALUE="<%=FactVolId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">
<INPUT TYPE="HIDDEN" NAME="ViewOnly" VALUE="<%=ViewOnly%>">

<H3 CLASS="HeadText"><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
       	<TR><TD ALIGN="CENTER">
	<% Month.WriteDatePeriod("Період", BegDate, EndDate, Month.Date[3], Month.Date[4]);
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



