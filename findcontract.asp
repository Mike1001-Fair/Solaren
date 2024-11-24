<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") == 1,
Title = "Договора";

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");
with (Html) {
	SetHead(Title);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindContract" ID="FindContract" ACTION="listcontract.asp" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="hidden" NAME="CustomerId" ID="CustomerId" VALUE="-1">
<H3 CLASS="HeadText"><BIG>&#128214;</BIG><%=Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<% Html.WriteSearchSet("Споживач", "Customer", "", 1)%>
	<FIELDSET><LEGEND>Рахунок</LEGEND>
	<INPUT TYPE="TEXT" TYPE="search" NAME="PAN" SIZE="10" MAXLENGTH="9">	
	</FIELDSET>
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>