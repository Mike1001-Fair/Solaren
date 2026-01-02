<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/find.set" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2;
if (User.CheckAccess(Authorized, "GET")) {
	Html.SetPage("Райони")
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindArea" ACTION="listarea.asp" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="HIDDEN" NAME="AreaId" ID="AreaId" VALUE="-1">
<H3 CLASS="HeadText"><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET><LEGEND>Назва</LEGEND>
	<INPUT TYPE="search" NAME="AreaName" ID="AreaName" PLACEHOLDER="Пошук по літерам" SIZE="30" LIST="AreaList" REQUIRED AUTOFOCUS>
	<DATALIST ID="AreaList"></DATALIST>
	</FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>


