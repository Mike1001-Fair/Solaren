<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Html) {
	SetHead("Обсяги");
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindFactVol" ACTION="listfactvol.asp" METHOD="post" TARGET="_blank" AUTOCOMPLETE="off">
<INPUT TYPE="hidden" NAME="ContractId" ID="ContractId" VALUE="-1">
<H3 CLASS="HeadText">Обсяги</H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<FIELDSET><LEGEND>Період</LEGEND>
	<INPUT TYPE="Month" NAME="BegMonth" VALUE="<%=Html.GetMonth(1)%>" MIN="<%=Html.GetMonth(1)%>" MAX="<%=Html.GetMonth(1)%>" REQUIRED> &#8722;
	<INPUT TYPE="Month" NAME="EndMonth" VALUE="<%=Html.GetMonth(1)%>" MIN="<%=Html.GetMonth(1)%>" MAX="<%=Html.GetMonth(1)%>" REQUIRED>
	</FIELDSET>

	<FIELDSET><LEGEND>Договiр</LEGEND>
	<LABEL>
	<INPUT TYPE="search" NAME="ContractName" ID="ContractName" PLACEHOLDER="Пошук по літерам" SIZE="35" LIST="ContractList" AUTOFOCUS REQUIRED>
	<DATALIST ID="ContractList"></DATALIST>
	</FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" DISABLED>&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>