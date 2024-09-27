<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Html) {
	SetHead("Пошук замовлень");
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindOrder" ACTION="listorder.asp" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="hidden" NAME="ContractId" ID="ContractId" VALUE="-1">
<H3 CLASS="HeadText">Пошук замовлень</H3>
<TABLE CLASS="MarkupTable">
       	<TR><TD ALIGN="CENTER">
	<FIELDSET><LEGEND><LABEL><INPUT TYPE="CheckBox" NAME="Deleted" TITLE="Видаленi">Перioд</LABEL></LEGEND>
	<INPUT TYPE="date" NAME="BegDate" VALUE="<%=Session("OperDate")%>" MIN="<%=Html.MinDate%>" MAX="<%=Session("EndDate")%>" REQUIRED> &#8722;
	<INPUT TYPE="date" NAME="EndDate" VALUE="<%=Session("EndDate")%>" MIN="<%=Html.MinDate%>"  REQUIRED>
	</FIELDSET>
	<% Html.WriteContractName("", "REQUIRED") %>
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>