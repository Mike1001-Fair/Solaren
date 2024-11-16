<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var RoleId = Session("RoleId"),
Authorized = RoleId >= 0 && RoleId < 2,
Title = "Новий пункт";
Resource.Load(User.ResourceFile());
Authorized ? Html.SetPage(Title, RoleId) : Solaren.SysMsg(2, Dictionary.Item("AuthorizationError"))%>

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