<%@LANGUAGE="JavaScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2;
if (Authorized) {
	with (Html) {
		SetHead("Пошук ЦОС");
		WriteScript();
		WriteMenu(Session("RoleId"), 0);
	}
} else {
	Solaren.SysMsg(2, "Помилка авторизації")
}%>
<BODY CLASS="MainBody" >
<FORM CLASS="ValidForm" NAME="FindBranch" ACTION="listbranch.asp" METHOD="post" AUTOCOMPLETE="off">
<H3 CLASS="HeadText">ЦОС</H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<FIELDSET><LEGEND>Назва</LEGEND>
		<INPUT TYPE="search" NAME="BranchName" SIZE="20" maxLength="10" REQUIRED AUTOFOCUS>
	</FIELDSET>
</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" DISABLED>&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>
