<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 2,
Title = "Нові показники";

if (User.ValidateAccess(Authorized, "GET")) {
	Html.SetPage(Title, User.RoleId)
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewIndicator" ACTION="createindicator.asp" METHOD="post" AUTOCOMPLETE="off">
<H3 CLASS="HeadText" ID="H3Id"><IMG CLASS="H3Img" SRC="Images/MeterIcon.svg" NAME="myImg"><%=Title%></H3>
<INPUT TYPE="HIDDEN" NAME="ContractId" ID="ContractId" VALUE="-1">
<INPUT TYPE="HIDDEN" NAME="PrevDate">
<INPUT TYPE="HIDDEN" NAME="Ktf">
<INPUT TYPE="HIDDEN" NAME="ContractPower">
<INPUT TYPE="HIDDEN" NAME="OperDate" VALUE="<%=Html.Date[1]%>">
<INPUT TYPE="HIDDEN" NAME="EndDate" VALUE="<%=Html.Date[2]%>">
<INPUT TYPE="HIDDEN" NAME="HoursLimit" VALUE="<%=Session("HoursLimit")%>">

<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER"> 
	<% Html.WriteSearchSet("Договір", "Contract", "", 1) %>
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT"><LABEL FOR="MeterId">Лiчильник</LABEL></TD><TD>
	<SELECT STYLE="width: 8em" NAME="MeterId" ID="MeterId" DISABLED><OPTION></OPTION></SELECT></TD></TR>
	<TR><TD ALIGN="RIGHT"><LABEL FOR="ReportDate">Дата</LABEL></TD>
	<TD><INPUT TYPE="date" NAME="ReportDate" ID="ReportDate" VALUE="<%=Html.Date[1]%>" MIN="<%=Html.Date[1]%>" MAX="<%=Html.Date[2]%>" REQUIRED DISABLED></TD></TR>
	</TABLE></FIELDSET>

	<FIELDSET NAME="IndicatorSet" DISABLED><LEGEND>Показники</LEGEND>
	<TABLE>
	<TR><TD>&nbsp</TD><TD ALIGN="CENTER">Останнi</TD><TD ALIGN="CENTER">Попереднi</TD><TD ALIGN="CENTER">Рiзниця</TD><TD>&nbsp</TD></TR>
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
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" DISABLED>Створити</BUTTON>
</FORM></BODY></HTML>
