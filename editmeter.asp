<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") == 1,
MeterId = Request.QueryString("MeterId");

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

try {
	Solaren.SetCmd("GetMeter");
	with (Cmd) {
		with (Parameters) {
    			Append(CreateParameter("MeterId", adInteger, adParamInput, 10, MeterId))
		}
	} 
	var rsMeter = Cmd.Execute();
	with (rsMeter) {
		var ContractId = Fields("ContractId").value,
		ContractName   = Fields("ContractName").value,
		MeterCode      = Fields("MeterCode").value,
		SetDate        = Fields("SetDate").value,
		Capacity       = Fields("Capacity").value,
		kTransForm     = Fields("kTransForm").value,
		RecVal         = Fields("RecVal").value,
		RetVal         = Fields("RetVal").value,
		Deleted        = Fields("Deleted").value,
		HeadTitle      = Deleted ? "Перегляд лічильника" : "Редагування лічильника",
		Limit          = Math.pow(10, Capacity) - 1;
		Close();
	}
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
} finally {	
	Connect.Close();
}

with (Html) {
	SetHead(HeadTitle);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditMeter" ACTION="updatemeter.asp" METHOD="POST" AUTOCOMPLETE="off">
<INPUT TYPE="HIDDEN" NAME="ContractId" ID="ContractId" VALUE="<%=ContractId%>">
<INPUT TYPE="HIDDEN" NAME="MeterId" VALUE="<%=MeterId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">

<H3 CLASS="HeadText">
	<IMG SRC="Images/MeterIcon.svg"><%=HeadTitle%>
</H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<% Html.WriteContractName(ContractName, "REQUIRED") %>
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Номер</TD>
	<TD><INPUT TYPE="text" NAME="MeterCode" VALUE="<%=MeterCode%>" SIZE="12" PATTERN="^\d{8,10}$" maxLength="10" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Монтаж</TD>
	<TD><INPUT TYPE="date" NAME="SetDate" VALUE="<%=SetDate%>" MIN="<%=Html.MinDate%>" MAX="<%=Session("EndDate")%>" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Розряднiсть</TD>
	<TD><INPUT TYPE="Number" NAME="Capacity" VALUE="<%=Capacity%>" MIN="5" MAX="9"  REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">Коефiцiєнт</TD>
	<TD><INPUT TYPE="Number" NAME="kTransForm" VALUE="<%=kTransForm%>" MIN="1" MAX="99" REQUIRED TITLE="трансформацiї"></TD></TR>
	</TABLE></FIELDSET>
	
	<FIELDSET><LEGEND>Показники</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Прийом</TD>
	<TD><INPUT TYPE="Number" NAME="RecVal" VALUE="<%=RecVal%>" MIN="0" MAX="<%=Limit%>"></TD></TR>

	<TR><TD ALIGN="RIGHT">Видача</TD>
	<TD><INPUT TYPE="Number" NAME="RetVal" VALUE="<%=RetVal%>" MIN="0" MAX="<%=Limit%>"></TD></TR>
	</TABLE></FIELDSET>
	</TD></TR>
</TABLE>
<% Html.WriteEditButton(1)%>
</FORM></BODY></HTML>