<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 0;
User.CheckAccess(Authorized, "GET");
Html.SetPage("Завантажити файл")%>

<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewUpLoad" ACTION="runupload.asp" METHOD="post"  enctype="multipart/form-data">
<H3 CLASS="H3Text">Надіслати файл</H3>
<DIV CLASS="SysMsg">
	<FIELDSET>
		<LEGEND>Параметри</LEGEND>
		<!--SPAN CLASS="UserIcon">&#x1F4E4;</SPAN-->
		<IMG CLASS="HeadImg" SRC="Images/upload.svg">
		<input type="file" name="Files" multiple REQUIRED>

	</FIELDSET>
</DIV>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>&#x1F4E4;Надіслати</BUTTON>
</FORM></BODY></HTML>


