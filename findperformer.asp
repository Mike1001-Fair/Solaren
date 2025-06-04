<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/referer.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->

<% var Authorized = User.RoleId == 1;
User.ValidateAccess(Authorized, "GET");
Html.SetPage("Користувачi")%>

<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindPerformer" ACTION="listperformer.asp" METHOD="post">
<H3 CLASS="HeadText">Пошук виконавця</H3>
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET><LEGEND ALIGN="CENTER">Прізвище</LEGEND>
	<INPUT TYPE="search" NAME="PerformerName" SIZE="20" maxLength="10" PLACEHOLDER="Назва" REQUIRED AUTOFOCUS>
	</FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>




