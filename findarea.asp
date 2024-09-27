<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2,
Title = "Райони";

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Html) {
	SetHead(Title);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindArea" ACTION="listarea.asp" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="HIDDEN" NAME="AreaId" ID="AreaId" VALUE="-1">
<H3 CLASS="HeadText"><%=Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET><LEGEND>Назва</LEGEND>
	<INPUT TYPE="search" NAME="AreaName" ID="AreaName" PLACEHOLDER="Пошук по літерам" SIZE="30" LIST="AreaList" REQUIRED AUTOFOCUS>
	<DATALIST ID="AreaList"></DATALIST>
	</FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>