<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") >= 0 || Session("RoleId") < 2,
Title = "Нова посада";
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Html) {
	SetHead(Title);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewChiefTitle" ACTION="createchieftitle.asp" METHOD="post" AUTOCOMPLETE="off">
<H3 CLASS="HeadText"><%=Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR ALIGN="CENTER"><TD>
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Хто?</TD>
	<TD><INPUT TYPE="TEXT" NAME="Title1" SIZE="30"  REQUIRED AUTOFOCUS></TD></TR>
	<TR><TD ALIGN="RIGHT">Кого?</TD>
	<TD><INPUT TYPE="TEXT" NAME="Title2" SIZE="30" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Кому?</TD>
	<TD><INPUT TYPE="TEXT" NAME="Title3" SIZE="30" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Ранг</TD>
	<TD><INPUT TYPE="Number" NAME="RankId" VALUE="1" MIN="1" MAX="4" TITLE="1-найвища посада" REQUIRED></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>Створити</BUTTON></FORM></BODY></HTML>