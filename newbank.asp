<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2;
if (User.CheckAccess(Authorized, "GET")) {
	Html.SetPage("Новий банк")
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewBank" ACTION="createbank.asp" METHOD="post" AUTOCOMPLETE="off">
<H3 CLASS="HeadText"><SPAN>&#127974;</SPAN><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE>	<TR><TD ALIGN="RIGHT">Код</TD>
	<TD><INPUT TYPE="TEXT" NAME="EdrpoCode" PLACEHOLDER="ЄДРПОУ" SIZE="10" MAXLENGTH="8" PATTERN="\d{8}" REQUIRED AUTOFOCUS></TD></TR>
	<TR><TD ALIGN="RIGHT">МФО</TD>
	<TD><INPUT TYPE="TEXT" NAME="MfoCode" SIZE="10" MAXLENGTH="6" PATTERN="\d{6}" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Назва</TD>
	<TD><INPUT TYPE="TEXT" NAME="BankName" PLACEHOLDER="Коротка без лапок" SIZE="30" MAXLENGTH="30" REQUIRED></TD></TR>
	</TABLE></FIELDSET></TD>
	</TR></TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>Створити</BUTTON>
</FORM></BODY></HTML>


