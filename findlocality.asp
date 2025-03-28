<%@ LANGUAGE="JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2;
if (User.ValidateAccess(Authorized, "GET")) {
	Html.SetPage("Населені пункти")
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindLocality" ACTION="listlocality.asp" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="hidden" NAME="LocalityId" ID="LocalityId" VALUE="-1">
<INPUT TYPE="hidden" NAME="LocalityType" ID="LocalityType" VALUE="-1">
<H3 CLASS="HeadText">&#127969;<%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<FIELDSET><LEGEND>Назва</LEGEND>
		<INPUT TYPE="search" NAME="LocalityName" ID="LocalityName" PLACEHOLDER="Пошук по літерам" SIZE="30" LIST="LocalityList" REQUIRED AUTOFOCUS>
		<DATALIST ID="LocalityList"></DATALIST>
	</FIELDSET>	
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>&#128270;Пошук</BUTTON></FORM></BODY></HTML>

