<%@ LANGUAGE="JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2;
if (User.ValidateAccess(Authorized, "GET")) {
	Html.SetPage("Країни", User.RoleId)
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindCountry" ACTION="listcountry.asp" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="hidden" NAME="CountryId" ID="CountryId" VALUE="-1">
<H3 CLASS="HeadText"><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<FIELDSET><LEGEND>Назва</LEGEND>
	<INPUT TYPE="search" NAME="CountryName" ID="CountryName" PLACEHOLDER="Пошук по літерам" SIZE="30" MAXLENGTH="30" LIST="CountryList" REQUIRED AUTOFOCUS>
	<DATALIST ID="CountryList"></DATALIST>
	</FIELDSET>
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>