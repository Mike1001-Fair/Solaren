<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = User.RoleId > 0 && User.RoleId < 3;
User.ValidateAccess(Authorized, "GET");
Html.SetPage("Вартicть по споживачу")%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindVolCost" ACTION="listvolcost.asp" METHOD="post" TARGET="_blank" AUTOCOMPLETE="off">
<INPUT TYPE="hidden" NAME="ContractId" ID="ContractId" VALUE="-1">
<H3 CLASS="HeadText"><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<% Month.WritePeriod();
	Html.WriteSearchSet("Договір", "Contract", "", 1);%>
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<LABEL><INPUT TYPE="CheckBox" NAME="TotReport">Всього</LABEL>
	</FIELDSET>
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" DISABLED>&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>



