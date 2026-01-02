<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/new.set" -->
<% var Authorized = User.RoleId == 2;
if (User.CheckAccess(Authorized, "GET")) {
	Html.SetPage("Нові показники")
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewIndicator" ACTION="createindicator.asp" METHOD="post" AUTOCOMPLETE="off">
<H3 CLASS="HeadText" ID="H3Id"><IMG CLASS="H3Img" SRC="Images/MeterIcon.svg" NAME="myImg"><%=Html.Title%></H3>
<INPUT TYPE="HIDDEN" NAME="ContractId" ID="ContractId" VALUE="-1">
<INPUT TYPE="HIDDEN" NAME="PrevDate">
<INPUT TYPE="HIDDEN" NAME="Ktf">
<INPUT TYPE="HIDDEN" NAME="ContractPower">
<INPUT TYPE="HIDDEN" NAME="OperDate" VALUE="<%=Month.Date[1]%>">
<INPUT TYPE="HIDDEN" NAME="EndDate" VALUE="<%=Month.Date[2]%>">
<INPUT TYPE="HIDDEN" NAME="HoursLimit" VALUE="<%=Session("HoursLimit")%>">

<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER"> 
	<% Html.WriteSearchSet("Договір", "Contract", "", 1) %>
	<FIELDSET><LEGEND>Лiчильник</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT"><LABEL FOR="MeterId">Номер</LABEL></TD><TD>
	<SELECT STYLE="width: 8em" NAME="MeterId" ID="MeterId" DISABLED></SELECT></TD></TR>
	<TR><TD ALIGN="RIGHT"><LABEL FOR="ReportDate">Дата</LABEL></TD>
	<TD><INPUT TYPE="date" NAME="ReportDate" ID="ReportDate" VALUE="<%=Month.Date[1]%>" MIN="<%=Month.Date[1]%>" MAX="<%=Month.Date[2]%>" REQUIRED DISABLED></TD></TR>
	</TABLE></FIELDSET>

	<FIELDSET NAME="IndicatorSet" DISABLED><LEGEND>Показники</LEGEND>
	<TABLE CLASS="Centered">
	<TR><TD>&nbsp</TD><TD>Останнi</TD><TD>Попереднi</TD><TD>Рiзниця</TD><TD>&nbsp</TD></TR>
	<TR><TD ALIGN="RIGHT"><LABEL FOR="RecVal">Прийом</LABEL></TD>
	<TD><INPUT TYPE="number" NAME="RecVal" ID="RecVal" MIN="0" MAX="9999999" REQUIRED></TD>
	<TD><INPUT TYPE="text" NAME="RecValPrev" SIZE="7" READONLY TABINDEX="-1"></TD>
	<TD><INPUT TYPE="text" NAME="RecSaldo" SIZE="7" READONLY TABINDEX="-1"></TD>
	<TD><INPUT TYPE="CheckBox" NAME="ZeroRec" TITLE="Перехiд через нуль"></TD></TR>

	<TR><TD ALIGN="RIGHT"><LABEL FOR="RetVal">Видача</LABEL></TD>
	<TD><INPUT TYPE="Number" NAME="RetVal" ID="RetVal" MIN="0" MAX="9999999" REQUIRED></TD>
	<TD><INPUT TYPE="text" NAME="RetValPrev" SIZE="7" READONLY TABINDEX="-1"></TD>
	<TD><INPUT TYPE="text" NAME="RetSaldo" SIZE="7" READONLY TABINDEX="-1"></TD>
	<TD><INPUT TYPE="CheckBox" NAME="ZeroRet" TITLE="Перехiд через нуль"></TD></TR>
	</TABLE></FIELDSET>

	<FIELDSET NAME="ResultSet" DISABLED><LEGEND>Результат</LEGEND>
	<SPAN ID="Saldo">Сальдо </SPAN><INPUT TYPE="text" NAME="TotSaldo" SIZE="7" READONLY TABINDEX="-1">
	</FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" DISABLED>✅Створити</BUTTON>
</FORM></BODY></HTML>



