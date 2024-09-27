<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% Resource.Load(User.ResourceFile());
var Authorized = Session("RoleId") >= 0 || Session("RoleId") < 2,
Title = "Новий пункт";

if (!Authorized) Solaren.SysMsg(2, Dictionary.Item("AuthorizationError"));

with (Html) {
	SetHead(Title);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewLocality" ACTION="createlocality.asp" METHOD="post" AUTOCOMPLETE="off">
<H3 CLASS="HeadText">&#127969;<%=Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR ALIGN="CENTER"><TD>
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT"><LABEL FOR="LocalityType">Тип</LABEL></TD>
	<TD><%Html.WriteLocalityType("LocalityType", -1)%></TD></TR>
	<TR><TD ALIGN="RIGHT"><LABEL FOR="LocalityName">Назва</LABEL></TD>
	<TD><INPUT TYPE="TEXT" NAME="LocalityName" ID="LocalityName" SIZE="30" MAXLENGTH="30" REQUIRED AUTOFOCUS></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>Створити</BUTTON></FORM>
</BODY></HTML>