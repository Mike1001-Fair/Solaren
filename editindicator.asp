<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = Session("RoleId") > 0 && Session("RoleId") < 3,
IndicatorId = Request.QueryString("IndicatorId");

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

try {
	Solaren.SetCmd("GetIndicator");
	with (Cmd) {
		with (Parameters) {
 			Append(CreateParameter("IndicatorId", adInteger, adParamInput, 10, IndicatorId)),
			Append(CreateParameter("ContractId", adInteger, adParamOutput, 10, 0)),
			Append(CreateParameter("ContractName", adVarChar, adParamOutput, 50, "")),
			Append(CreateParameter("ContractPower", adVarChar, adParamOutput, 10, "")),
			Append(CreateParameter("ReportDate", adVarChar, adParamOutput, 10, "")),
			Append(CreateParameter("MeterId", adInteger, adParamOutput, 10, 0)),
			Append(CreateParameter("MeterCode", adVarChar, adParamOutput, 10, "")),
			Append(CreateParameter("Capacity", adTinyInt, adParamOutput, 10, 0)),
			Append(CreateParameter("Ktf", adTinyInt, adParamOutput, 10, 0)),
			Append(CreateParameter("RecVal", adInteger, adParamOutput, 10, 0)),
			Append(CreateParameter("RetVal", adInteger, adParamOutput, 10, 0)),
			Append(CreateParameter("RecValPrev", adInteger, adParamOutput, 10, 0)),
			Append(CreateParameter("RetValPrev", adInteger, adParamOutput, 10, 0)),
			Append(CreateParameter("PrevDate", adVarChar, adParamOutput, 10, ""));
			Append(CreateParameter("Deleted", adBoolean, adParamOutput, 1, 0));
		} Execute(adExecuteNoRecords);
	}

	with (Cmd.Parameters) {
	    var ContractId    = Item("ContractId").value,
		ContractName  = Item("ContractName").value,
		ContractPower = Item("ContractPower").value,
		ReportDate    = Item("ReportDate").value,
		MeterId       = Item("MeterId").value,
		MeterCode     = Item("MeterCode").value,
		Capacity      = Item("Capacity").value,
		Ktf           = Item("Ktf").value,
		RecVal        = Item("RecVal").value,
		RetVal        = Item("RetVal").value,
		RecValPrev    = Item("RecValPrev").value,
		RetValPrev    = Item("RetValPrev").value,
		PrevDate      = Item("PrevDate").value,
		Deleted       = Item("Deleted").value,
		Limit         = Math.pow(10, Capacity) - 1;
	}
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
} finally {	
	Connect.Close();
}

var ViewOnly = !Month.isPeriod(Session("OperDate"), ReportDate),
HeadTitle    = Deleted || ViewOnly ? "Перегляд показникiв" : "Редагування показникiв";

with (Html) {
	SetHead(HeadTitle);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditIndicator" ACTION="updateindicator.asp" METHOD="POST" AUTOCOMPLETE="off">
<INPUT TYPE="HIDDEN" NAME="ContractId" ID="ContractId" VALUE="<%=ContractId%>">
<INPUT TYPE="HIDDEN" NAME="IndicatorId" VALUE="<%=IndicatorId%>">
<INPUT TYPE="HIDDEN" NAME="PrevDate" VALUE="<%=PrevDate%>">
<INPUT TYPE="HIDDEN" NAME="Ktf" VALUE="<%=Ktf%>">
<INPUT TYPE="HIDDEN" NAME="ContractPower" VALUE="<%=ContractPower%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">
<INPUT TYPE="HIDDEN" NAME="ViewOnly" VALUE="<%=ViewOnly%>">
<INPUT TYPE="HIDDEN" NAME="OperDate" VALUE="<%=Session("OperDate")%>">
<INPUT TYPE="HIDDEN" NAME="EndDate" VALUE="<%=Session("EndDate")%>">
<INPUT TYPE="HIDDEN" NAME="HoursLimit" VALUE="<%=Session("HoursLimit")%>">
<H3 CLASS="HeadText" ID="H3Id">
	<IMG CLASS="H3Img" SRC="images/MeterIcon.svg" NAME="myImg"><%=HeadTitle%>
</H3>

<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<% Html.WriteContractName(ContractName, "REQUIRED") %>
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT"><LABEL FOR="MeterId">Лiчильник</LABEL></TD>
	<TD><SELECT NAME="MeterId" ID="MeterId" ID="MeterId" STYLE="width: 8em">
	<OPTION></OPTION><OPTION VALUE="<%=MeterId%>" SELECTED><%=MeterCode%></OPTION></SELECT></TD></TR>
	<TR><TD ALIGN="RIGHT"><LABEL FOR="ReportDate">Дата</LABEL></TD>
	<TD><INPUT TYPE="date" NAME="ReportDate" ID="ReportDate" VALUE="<%=ReportDate%>" MIN="<%=Session("OperDate")%>" MAX="<%=Session("NextDate")%>" REQUIRED></TD></TR>
	</TABLE></FIELDSET>

	<FIELDSET NAME="IndicatorSet"><LEGEND>Показники</LEGEND>
	<TABLE><TR><TD>&nbsp</TD><TD ALIGN="CENTER">Останнi</TD><TD ALIGN="CENTER">Попереднi</TD><TD ALIGN="CENTER">Рiзниця</TD><TD>&nbsp</TD></TR>

	<TR><TD ALIGN="RIGHT"><LABEL FOR="RecVal">Прийом</LABEL></TD>
	<TD><INPUT TYPE="Number" NAME="RecVal" ID="RecVal" VALUE="<%=RecVal%>" MIN="0" MAX="<%=Limit%>" REQUIRED></TD>
	<TD><INPUT TYPE="text" NAME="RecValPrev" VALUE="<%=RecValPrev%>" SIZE="7" READONLY TABINDEX="-1"></TD>
	<TD><INPUT TYPE="text" NAME="RecSaldo" SIZE="7" READONLY TABINDEX="-1"></TD>
	<TD><INPUT TYPE="CheckBox" NAME="ZeroRec" TITLE="Перехiд через нуль"></TD></TR>

	<TR><TD ALIGN="RIGHT"><LABEL FOR="RetVal">Видача</LABEL></TD>
	<TD><INPUT TYPE="Number" NAME="RetVal" ID="RetVal" VALUE="<%=RetVal%>" MIN="0" MAX="<%=Limit%>" REQUIRED></TD>
	<TD><INPUT TYPE="text" NAME="RetValPrev" VALUE="<%=RetValPrev%>" SIZE="7" READONLY TABINDEX="-1"></TD>
	<TD><INPUT TYPE="text" NAME="RetSaldo" SIZE="7" READONLY TABINDEX="-1"></TD>
	<TD><INPUT TYPE="CheckBox" NAME="ZeroRet" TITLE="Перехiд через нуль"></TD></TR>
	</TABLE></FIELDSET>

	<FIELDSET NAME="ResultSet" ALIGN="CENTER"><LEGEND>Результат</LEGEND>
	<SPAN ID="Saldo">Сальдо </SPAN><INPUT TYPE="text" NAME="TotSaldo" SIZE="7" READONLY TABINDEX="-1">
	</FIELDSET>
	</TD></TR>
</TABLE>
<% if (!ViewOnly) Html.WriteEditButton(Session("RoleId") == 2)%>
</FORM></BODY></HTML>