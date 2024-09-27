<%@ LANGUAGE="JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2,
Title = "Населені пункти";

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Html) {
	SetHead(Title);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindLocality" ACTION="listlocality.asp" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="hidden" NAME="LocalityId" ID="LocalityId" VALUE="-1">
<INPUT TYPE="hidden" NAME="LocalityType" ID="LocalityType" VALUE="-1">
<H3 CLASS="HeadText">&#127969;<%=Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<FIELDSET><LEGEND>Назва</LEGEND>
		<INPUT TYPE="search" NAME="LocalityName" ID="LocalityName" PLACEHOLDER="Пошук по літерам" SIZE="30" LIST="LocalityList" REQUIRED AUTOFOCUS>
		<DATALIST ID="LocalityList"></DATALIST>
	</FIELDSET>	
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>&#128270;Пошук</BUTTON></FORM></BODY></HTML>
