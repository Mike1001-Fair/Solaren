<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<% var Authorized = Session("RoleId") == 0,
Title = "Користувачi";

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Html) {
	SetHead(Title);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%> 
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindUser" ACTION="listusers.asp" METHOD="post" AUTOCOMPLETE="off">
<H3 CLASS="HeadText"><%=Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Логiн</TD>
	<TD><INPUT TYPE="text" NAME="LoginId" SIZE="10" REQUIRED AUTOFOCUS></TD></TR>
	<TR><TD ALIGN="RIGHT">Роль</TD>
	<TD><%Html.WriteRole("RoleId", -1)%></TD></TR>	
	<TR><TD ALIGN="RIGHT">Підключився</TD>
	<TD><INPUT TYPE="datetime-local" NAME="ConnectDate" MAX="<%=Session("Today")+'T24:00'%>" TITLE="Підключився"></TD></TR>
	</TABLE></FIELDSET>
</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>