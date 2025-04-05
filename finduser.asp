<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<% var Authorized = User.RoleId == 0,
Today = new Date();
User.ValidateAccess(Authorized, "GET");
Html.SetPage("Користувачi")%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindUser" ACTION="listusers.asp" METHOD="post" AUTOCOMPLETE="off">
<H3 CLASS="HeadText"><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Логiн</TD>
	<TD><INPUT TYPE="text" NAME="LoginId" SIZE="10" REQUIRED AUTOFOCUS></TD></TR>
	<TR><TD ALIGN="RIGHT">Роль</TD>
	<TD><%User.WriteRole("RoleId", -1)%></TD></TR>	
	<TR><TD ALIGN="RIGHT">Підключився</TD>
	<TD><INPUT TYPE="datetime-local" NAME="ConnectDate" MAX="<%=Today.toStr(1)%>" TITLE="Підключився"></TD></TR>
	</TABLE></FIELDSET>
</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>


