<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<% var Authorized = Session("RoleId") == 0;
if (!Authorized) Message.Write(2, "Помилка авторизації");

with (Html) {
	SetHead("Завантажити файл");
	Menu.Write(Session("RoleId"), 0);
}%>

<!DOCTYPE HTML>
<SCRIPT>
function SbmForm() {
	let Confirmed = confirm("Вы впевненi ?");
	if (Confirmed) Loader.Show();
	return Confirmed
}
</SCRIPT>

<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewUpLoad" ACTION="runupload.asp" METHOD="post"  enctype="multipart/form-data">
<H3 CLASS="H3Text">Надіслати файл</H3>
<DIV CLASS="SysMsg">
	<FIELDSET>
		<LEGEND>Параметри</LEGEND>
		<!--SPAN CLASS="UserIcon">&#x1F4E4;</SPAN-->
		<IMG CLASS="HeadImg" SRC="Images/upload.svg">
		<input type="file" name="files[]" multiple>
	</FIELDSET>
</DIV>
<BUTTON CLASS="SbmBtn"  NAME="SbmBtn" ONCLICK="return SbmForm()">&#x1F4E4;Надіслати</BUTTON>
</FORM></BODY></HTML>
