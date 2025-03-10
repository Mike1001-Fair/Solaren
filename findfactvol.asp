<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1;
if (User.ValidateAccess(Authorized, "GET")) {
	Html.SetPage("Обсяги", User.RoleId)
}%>

<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindFactVol" ACTION="listfactvol.asp" METHOD="post" TARGET="_blank" AUTOCOMPLETE="off">
<INPUT TYPE="hidden" NAME="ContractId" ID="ContractId" VALUE="-1">
<H3 CLASS="HeadText">Обсяги</H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<FIELDSET><LEGEND>Період</LEGEND>
	<INPUT TYPE="Month" NAME="BegMonth" VALUE="<%=Month.GetMonth(1)%>" MIN="<%=Month.GetMonth(1)%>" MAX="<%=Month.GetMonth(1)%>" REQUIRED> &#8722;
	<INPUT TYPE="Month" NAME="EndMonth" VALUE="<%=Month.GetMonth(1)%>" MIN="<%=Month.GetMonth(1)%>" MAX="<%=Month.GetMonth(1)%>" REQUIRED>
	</FIELDSET>

	<FIELDSET><LEGEND>Договiр</LEGEND>
	<LABEL>
	<INPUT TYPE="search" NAME="ContractName" ID="ContractName" PLACEHOLDER="Пошук по літерам" SIZE="35" LIST="ContractList" AUTOFOCUS REQUIRED>
	<DATALIST ID="ContractList"></DATALIST>
	</FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" DISABLED>&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>
