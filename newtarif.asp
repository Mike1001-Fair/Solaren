<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") == 1,
Title = "Новий тариф";

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Html) {
	SetHead(Title);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewTarif" ACTION="createtarif.asp" METHOD="post" AUTOCOMPLETE="off">
<H3 CLASS="HeadText"><%=Title%></H3>

<TABLE CLASS="MarkupTable">
	<TR><TD>
	<% Html.WriteDatePeriod("Дiє", Session("OperDate"), Session("EndDate"), Html.MinDate, Html.MaxDate) %>
	<FIELDSET><LEGEND>Ввод в експлуатацію</LEGEND>
	<INPUT TYPE="date" NAME="ExpDateBeg" MIN="<%=Html.MinDate%>" MAX="<%=Html.MaxDate%>" REQUIRED> &#8722;
	<INPUT TYPE="date" NAME="ExpDateEnd" MIN="<%=Html.MinDate%>" MAX="<%=Html.MaxDate%>" REQUIRED>
	</FIELDSET>

	<FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Група</TD>
	<TD><%Html.WriteTarif("GroupId", -1)%></TD></TR>
	<TR><TD ALIGN="RIGHT">Тариф</TD>
	<TD><INPUT TYPE="Number" NAME="Tarif" STEP="0.01" MIN="0" MAX="999999" REQUIRED PLACEHOLDER="коп"></TD></TR>
	</TABLE></FIELDSET>
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>Створити</BUTTON>
</FORM></BODY></HTML>
