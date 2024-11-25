<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<% var Authorized = User.RoleId == 1,
Title = "Новий лiчильник";

if (User.ValidateAccess(Authorized)) {
	Html.SetPage(Title, User.RoleId)
}%>

<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewMeter" ACTION="createmeter.asp" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="hidden" NAME="ContractId" ID="ContractId" VALUE="-1">
<H3 CLASS="HeadText"><IMG SRC="Images/MeterIcon.svg"><%=Title%></H3>

<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<% Html.WriteSearchSet("Договір", "Contract", "", 1) %>
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Номер</TD>
	<TD><INPUT TYPE="text" NAME="MeterCode" SIZE="12" maxLength="10" PATTERN="^\d{8,10}$" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Монтаж</TD>
	<TD><INPUT TYPE="date" NAME="SetDate" VALUE="<%=Html.Date[0]%>" MIN="<%=Html.Date[3]%>" MAX="<%=Html.Date[1]%>" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Розряднiсть</TD>
	<TD><INPUT TYPE="Number" NAME="Capacity" VALUE="7" STEP="1" MIN="5" MAX="9" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">Коефiцiєнт</TD>
	<TD><INPUT TYPE="Number" NAME="kTransForm" VALUE="1" STEP="1" MIN="1" MAX="99" REQUIRED></TD></TR>
	</TABLE></FIELDSET>

	<FIELDSET><LEGEND>Показники</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Прийом</TD>
	<TD><INPUT TYPE="Number" NAME="RecVal" VALUE="0" MIN="0" MAX="9999999" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Видача</TD>
	<TD><INPUT TYPE="Number" NAME="RetVal" VALUE="0" MIN="0" MAX="9999999" REQUIRED></TD></TR>
	</TABLE></FIELDSET>
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>Створити</BUTTON>
</FORM></BODY></HTML>