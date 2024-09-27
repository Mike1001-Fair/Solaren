<%@ LANGUAGE="JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2,
Title = "Вулицi";

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Html) {
	SetHead(Title);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindStreet" ACTION="liststreet.asp" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="hidden" NAME="StreetId" ID="StreetId" VALUE="-1">
<INPUT TYPE="hidden" NAME="StreetType" ID="StreetType" VALUE="-1">
<H3 CLASS="HeadText"><%=Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<FIELDSET><LEGEND>Назва</LEGEND>
	<INPUT TYPE="search" NAME="StreetName" ID="StreetName" PLACEHOLDER="Пошук по літерам" SIZE="30" LIST="StreetList" REQUIRED AUTOFOCUS>
	<DATALIST ID="StreetList"></DATALIST>
	</FIELDSET>
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>