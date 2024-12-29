<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<!-- #INCLUDE FILE="Include/tarif.inc" -->
<% var Authorized = User.RoleId == 1;

if (User.ValidateAccess(Authorized, "GET")) {
	Html.SetPage("Новий тариф", User.RoleId)
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewTarif" ACTION="createtarif.asp" METHOD="post" AUTOCOMPLETE="off">
<H3 CLASS="HeadText"><%=Html.Title%></H3>

<TABLE CLASS="MarkupTable">
	<TR><TD>
	<% Html.WriteDatePeriod("Дiє", Month.Date[1], Month.Date[2], Month.Date[0], Month.Date[4]) %>
	<FIELDSET><LEGEND>Ввод в експлуатацію</LEGEND>
	<INPUT TYPE="date" NAME="ExpDateBeg" MIN="<%=Month.Date[0]%>" MAX="<%=Month.Date[4]%>" REQUIRED> &#8722;
	<INPUT TYPE="date" NAME="ExpDateEnd" MIN="<%=Month.Date[0]%>" MAX="<%=Month.Date[4]%>" REQUIRED>
	</FIELDSET>

	<FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Група</TD>
	<TD><%Tarif.Write("GroupId", -1)%></TD></TR>
	<TR><TD ALIGN="RIGHT">Тариф</TD>
	<TD><INPUT TYPE="Number" NAME="Tarif" STEP="0.01" MIN="0" MAX="999999" REQUIRED PLACEHOLDER="коп"></TD></TR>
	</TABLE></FIELDSET>
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>Створити</BUTTON>
</FORM></BODY></HTML>