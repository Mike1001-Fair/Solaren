<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Include/new.inc" -->

<% var Authorized = User.RoleId >= 0 && User.RoleId < 2;
if (User.CheckAccess(Authorized, "GET")) {
	Html.SetPage("Нова країна")
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewCountry" ACTION="createcountry.asp" METHOD="POST" AUTOCOMPLETE="off">
<H3 CLASS="HeadText">&#127757;<%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET NAME="CountrySet"><LEGEND>Параметри</LEGEND>
	<TABLE>
	<TR><TD>Назва</TD>
	<TD><INPUT TYPE="TEXT" NAME="CountryName" SIZE="30" MAXLENGTH="30" REQUIRED AUTOFOCUS></TD></TR>
	<TR><TD>Tld-код</TD>
	<TD><INPUT TYPE="TEXT" NAME="TldCode" SIZE="10" MAXLENGTH="10" REQUIRED></TD></TR>
	<TR><TD>Iso-код</TD>
	<TD><INPUT TYPE="TEXT" NAME="IsoCode" SIZE="10" MAXLENGTH="10" REQUIRED></TD></TR>
	<TR><TD>Itu-код</TD>
	<TD><INPUT TYPE="TEXT" NAME="ItuCode" SIZE="10" MAXLENGTH="10" REQUIRED></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>Створити</BUTTON>
</FORM></BODY></HTML>


