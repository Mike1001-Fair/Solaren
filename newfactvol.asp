<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1,
Title = "Новий обсяг";
if (User.ValidateAccess(Authorized)) {
	Html.SetPage(Title, User.RoleId)
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewFactVol" ACTION="createfactvol.asp" METHOD="post">
<INPUT TYPE="HIDDEN" NAME="ContractId" ID="ContractId" VALUE="-1">
<H3 CLASS="HeadText"><%=Title%></H3>
<TABLE CLASS="MarkupTable">
       	<TR><TD ALIGN="CENTER">
	<% with (Html) {
		WriteDatePeriod("Період", Html.Date[1], Html.Date[2], Html.Date[1], Html.Date[2]);
		WriteSearchSet("Договір", "Contract", "", 1);
	}%>
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
