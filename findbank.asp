<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Include/find.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2;

if (User.CheckAccess(Authorized, "GET")) {
	Html.SetPage("Банки")
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindBank" ACTION="listbank.asp" METHOD="post" AUTOCOMPLETE="off">
<H3 CLASS="HeadText"><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<FIELDSET><LEGEND>Назва</LEGEND>
		<INPUT TYPE="TEXT" NAME="BankName" SIZE="20" maxLength="10" REQUIRED AUTOFOCUS>
	</FIELDSET>
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>



