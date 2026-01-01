<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Include/edit.inc" -->
<% var Authorized = User.RoleId == 1,
Query = Solaren.Parse();
User.CheckAccess(Authorized, "GET");

try {
	Solaren.SetCmd("GetMeter");
	with (Cmd) {
		with (Parameters) {
    			Append(CreateParameter("MeterId", adInteger, adParamInput, 10, Query.MeterId))
		}
	} 
	var rs = Solaren.Execute("GetMeter");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {	
	var Meter = Solaren.Map(rs.Fields),
	Limit = Math.pow(10, Meter.Capacity) - 1;
	rs.Close();
	Solaren.Close();
	Html.SetPage(Meter.Deleted ? "Перегляд лічильника" : "Редагування лічильника");
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditMeter" ACTION="updatemeter.asp" METHOD="POST" AUTOCOMPLETE="off">
<INPUT TYPE="HIDDEN" NAME="ContractId" ID="ContractId" VALUE="<%=Meter.ContractId%>">
<INPUT TYPE="HIDDEN" NAME="MeterId" VALUE="<%=Query.MeterId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Meter.Deleted%>">

<H3 CLASS="HeadText">
	<IMG SRC="Images/MeterIcon.svg"><%=Html.Title%>
</H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<% Html.WriteSearchSet("Договір", "Contract", Meter.ContractName, 1) %>
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Номер</TD>
	<TD><INPUT TYPE="text" NAME="MeterCode" VALUE="<%=Meter.MeterCode%>" SIZE="12" PATTERN="^\d{8,10}$" maxLength="10" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Монтаж</TD>
	<TD><INPUT TYPE="date" NAME="SetDate" VALUE="<%=Meter.SetDate%>" MIN="<%=Month.Date[0]%>" MAX="<%=Month.Date[2]%>" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Розряднiсть</TD>
	<TD><INPUT TYPE="Number" NAME="Capacity" VALUE="<%=Meter.Capacity%>" MIN="5" MAX="9"  REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">Коефiцiєнт</TD>
	<TD><INPUT TYPE="Number" NAME="kTransForm" VALUE="<%=Meter.kTransForm%>" MIN="1" MAX="99" REQUIRED TITLE="трансформацiї"></TD></TR>
	</TABLE></FIELDSET>
	
	<FIELDSET><LEGEND>Показники</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Прийом</TD>
	<TD><INPUT TYPE="Number" NAME="RecVal" VALUE="<%=Meter.RecVal%>" MIN="0" MAX="<%=Limit%>" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">Видача</TD>
	<TD><INPUT TYPE="Number" NAME="RetVal" VALUE="<%=Meter.RetVal%>" MIN="0" MAX="<%=Limit%>" REQUIRED></TD></TR>
	</TABLE></FIELDSET>
	</TD></TR>
</TABLE>
<% Html.WriteEditButton(1, Meter.Deleted)%>
</FORM></BODY></HTML>



