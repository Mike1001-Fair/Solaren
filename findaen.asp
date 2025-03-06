<%@LANGUAGE="JavaScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2;
if (Authorized) {
	with (Html) {
		SetHead("Пошук РЕМ");
		Menu.Write(Session("RoleId"), 0);
	}
} else {
	Message.Write(2, "Помилка авторизації")
}%>
<SCRIPT>
function ChkForm() {
	with (FindAen) {
		SbmBtn.disabled = !AenName.validity.valid
	}
} 

function SbmForm() {
	with (FindAen) {
		AenName.value = AenName.value.trim();
	}
}
</SCRIPT>

<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindAen" ACTION="listaen.asp" METHOD="post" ONINPUT="ChkForm()">
<H3 CLASS="HeadText">РЕМ</H3>
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET><LEGEND><LABEL><INPUT TYPE="CheckBox" NAME="Deleted">Видаленi</LABEL></LEGEND>
	<INPUT TYPE="TEXT" NAME="AenName" PLACEHOLDER="Назва" SIZE="20" maxLength="10" REQUIRED AUTOFOCUS>
	</FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ONCLICK="SbmForm()" DISABLED>&#128270;Пошук</BUTTON></FORM></BODY></HTML>
