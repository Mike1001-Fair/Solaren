<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/referer.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->

<% var Authorized = User.RoleId >= 0 && User.RoleId < 2;
User.ValidateAccess(Authorized, "GET");
Html.SetPage("Нова посада")%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewChiefTitle" ACTION="createchieftitle.asp" METHOD="post" AUTOCOMPLETE="off">
<H3 CLASS="HeadText"><%=Html.Title%></H3>
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


