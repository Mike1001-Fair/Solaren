<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE VIRTUAL="Solaren/Include/new.inc" -->
<% var Authorized = User.RoleId == 1;
if (User.CheckAccess(Authorized, "GET")) {
	Html.SetPage("Новий обсяг")
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewFactVol" ACTION="createfactvol.asp" METHOD="post">
<INPUT TYPE="HIDDEN" NAME="ContractId" ID="ContractId" VALUE="-1">
<H3 CLASS="HeadText"><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
       	<TR><TD ALIGN="CENTER">
	<% Month.WriteDatePeriod("Період", Month.Date[1], Month.Date[2], Month.Date[1], Month.Date[2]);
	Html.WriteSearchSet("Договір", "Contract", "", 1);%>
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT"><LABEL FOR="RecVol">Прийом</LABEL></TD>
	<TD><INPUT TYPE="Number" NAME="RecVol" ID="RecVol" STEP="1" MIN="0" MAX="999999" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT"><LABEL FOR="ReTVol">Видача</LABEL></TD>
	<TD><INPUT TYPE="Number" NAME="RetVol" ID="RetVol" STEP="1" MIN="0" MAX="999999" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT" ID="SaldoId">Сальдо</TD>
	<TD><INPUT TYPE="text" NAME="Saldo" READONLY SIZE="7" maxLength="7"></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>Створити</BUTTON>
</FORM></BODY></HTML>



