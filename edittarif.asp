<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/edit.set" -->
<% var Authorized = User.RoleId == 1,
Query = Webserver.Parse();
User.CheckAccess(Authorized, "GET");

try {
	Solaren.SetCmd("GetTarif");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("TarifId", adVarChar, adParamInput, 10, Query.TarifId));
		}
	}
	var rs = Solaren.Execute("GetTarif");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	var Record = Webserver.Map(rs.Fields),
	ViewOnly = !Month.isPeriod(Month.Date[1], Record.EndDate),
	Title = Record.Deleted || ViewOnly ? "Перегляд тарифу" : "Редагування тарифу";
	rs.Close();
	Solaren.Close();
	Html.SetPage(Title)
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditTarif" ACTION="updatetarif.asp" METHOD="POST">
<INPUT TYPE="HIDDEN" NAME="TarifId" VALUE="<%=Query.TarifId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Record.Deleted%>">
<INPUT TYPE="HIDDEN" NAME="ViewOnly" VALUE="<%=ViewOnly%>">
<H3 CLASS="HeadText"><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<% Month.WriteDatePeriod("Дiє", Record.BegDate, Record.EndDate, Month.Date[0], Month.Date[4]) %>
	<FIELDSET><LEGEND>Ввод в експлуатацію</LEGEND>
	<INPUT TYPE="date" NAME="ExpDateBeg" VALUE="<%=Record.ExpDateBeg%>" MIN="<%=Month.Date[0]%>" MAX="<%=Month.Date[4]%>" REQUIRED> &#8722;
	<INPUT TYPE="date" NAME="ExpDateEnd" VALUE="<%=Record.ExpDateEnd%>" MIN="<%=Month.Date[0]%>" MAX="<%=Month.Date[4]%>" REQUIRED>
	</FIELDSET>

	<FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Група</TD>
	<TD><%Tarif.Write("GroupId", Record.GroupId)%></TD></TR>

	<TR><TD ALIGN="RIGHT">Тариф</TD>
	<TD><INPUT TYPE="Number" NAME="Tarif" VALUE="<%=Record.Tarif%>" STEP="0.01" MIN="0" MAX="999999" REQUIRED TITLE="коп"></TD></TR>
	</TABLE></FIELDSET>                                                
	</TD></TR>
</TABLE>
<% if (!ViewOnly) {
	Html.WriteEditButton(1, Record.Deleted)
}%>
</FORM></BODY></HTML>