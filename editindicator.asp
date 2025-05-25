<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = User.RoleId > 0 && User.RoleId < 3,
IndicatorId = Request.QueryString("IndicatorId");
User.ValidateAccess(Authorized, "GET");

try {
	Solaren.SetCmd("GetIndicator");
	with (Cmd) {
		with (Parameters) {
 			Append(CreateParameter("IndicatorId", adInteger, adParamInput, 10, IndicatorId))
		} 
	}
	var rs = Solaren.Execute("GetIndicator");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {	
	Record.Map(rs);
	rs.Close();
	Solaren.Close();
}

var OperDate = Month.Date[1],
PrevDate     = Month.GetYMD(Record.PrevDate),
ReportDate   = Month.GetYMD(Record.ReportDate),
NextDate     = Month.Date[3],
ViewOnly     = !Month.isPeriod(OperDate, ReportDate),
Limit        = Math.pow(10, Record.Capacity) - 1,
AllowDelBtn  = User.RoleId == 1;

Html.Title = Record.Deleted || ViewOnly ? "Перегляд показникiв" : "Редагування показникiв";
Html.SetPage()%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditIndicator" ACTION="updateindicator.asp" METHOD="POST" AUTOCOMPLETE="off">
<INPUT TYPE="HIDDEN" NAME="ContractId" ID="ContractId" VALUE="<%=Record.ContractId%>">
<INPUT TYPE="HIDDEN" NAME="IndicatorId" VALUE="<%=IndicatorId%>">
<INPUT TYPE="HIDDEN" NAME="PrevDate" VALUE="<%=PrevDate%>">
<INPUT TYPE="HIDDEN" NAME="Ktf" VALUE="<%=Record.Ktf%>">
<INPUT TYPE="HIDDEN" NAME="ContractPower" VALUE="<%=Record.ContractPower%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Record.Deleted%>">
<INPUT TYPE="HIDDEN" NAME="ViewOnly" VALUE="<%=ViewOnly%>">
<INPUT TYPE="HIDDEN" NAME="OperDate" VALUE="<%=OperDate%>">
<INPUT TYPE="HIDDEN" NAME="EndDate" VALUE="<%=Month.Date[2]%>">
<INPUT TYPE="HIDDEN" NAME="HoursLimit" VALUE="<%=Session("HoursLimit")%>">
<H3 CLASS="HeadText" ID="H3Id">
	<IMG CLASS="H3Img" SRC="images/MeterIcon.svg" NAME="myImg"><%=Html.Title%>
</H3>

<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<% Html.WriteSearchSet("Договір", "Contract", Record.ContractName, 1) %>
	<FIELDSET><LEGEND>Лiчильник</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT"><LABEL FOR="MeterId">Номер</LABEL></TD>
	<TD><SELECT NAME="MeterId" ID="MeterId" STYLE="width: 8em">
	<OPTION></OPTION><OPTION VALUE="<%=Record.MeterId%>" SELECTED><%=Record.MeterCode%></OPTION></SELECT></TD></TR>
	<TR><TD ALIGN="RIGHT"><LABEL FOR="ReportDate">Дата</LABEL></TD>
	<TD><INPUT TYPE="date" NAME="ReportDate" ID="ReportDate" VALUE="<%=ReportDate%>" MIN="<%=OperDate%>" MAX="<%=NextDate%>" REQUIRED></TD></TR>
	</TABLE></FIELDSET>

	<FIELDSET NAME="IndicatorSet"><LEGEND>Показники</LEGEND>
	<TABLE CLASS="Centered"><TR><TD>&nbsp</TD><TD>Останнi</TD><TD>Попереднi</TD><TD>Рiзниця</TD><TD>&nbsp</TD></TR>

	<TR><TD ALIGN="RIGHT"><LABEL FOR="RecVal">Прийом</LABEL></TD>
	<TD><INPUT TYPE="Number" NAME="RecVal" ID="RecVal" VALUE="<%=Record.RecVal%>" MIN="0" MAX="<%=Limit%>" REQUIRED></TD>
	<TD><INPUT TYPE="text" NAME="RecValPrev" VALUE="<%=Record.PrevRecVal%>" SIZE="7" READONLY TABINDEX="-1"></TD>
	<TD><INPUT TYPE="text" NAME="RecSaldo" SIZE="7" READONLY TABINDEX="-1"></TD>
	<TD><INPUT TYPE="CheckBox" NAME="ZeroRec" TITLE="Перехiд через нуль"></TD></TR>

	<TR><TD ALIGN="RIGHT"><LABEL FOR="RetVal">Видача</LABEL></TD>
	<TD><INPUT TYPE="Number" NAME="RetVal" ID="RetVal" VALUE="<%=Record.RetVal%>" MIN="0" MAX="<%=Limit%>" REQUIRED></TD>
	<TD><INPUT TYPE="text" NAME="RetValPrev" VALUE="<%=Record.PrevRetVal%>" SIZE="7" READONLY TABINDEX="-1"></TD>
	<TD><INPUT TYPE="text" NAME="RetSaldo" SIZE="7" READONLY TABINDEX="-1"></TD>
	<TD><INPUT TYPE="CheckBox" NAME="ZeroRet" TITLE="Перехiд через нуль"></TD></TR>
	</TABLE></FIELDSET>

	<FIELDSET NAME="ResultSet" ALIGN="CENTER"><LEGEND>Результат</LEGEND>
	<SPAN ID="Saldo">Сальдо </SPAN><INPUT TYPE="text" NAME="TotSaldo" SIZE="7" READONLY TABINDEX="-1">
	</FIELDSET>
	</TD></TR>
</TABLE>
<% if (!ViewOnly) Html.WriteEditButton(AllowDelBtn, Record.Deleted)%>
</FORM></BODY></HTML>


