<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") == 1,
TitleHead = "Закриття мicяця";

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Html) {
	SetHead(TitleHead);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewMonth" ACTION="runmonthclosing.asp" METHOD="post">
<H3 CLASS="HeadText"><%=TitleHead%></H3>
<DIV CLASS="SysMsg">
	<FIELDSET>
	<LEGEND>Перioд</LEGEND>
	<FIGURE>
		<IMG SRC="Images/cycle.png">
		<FIGCAPTION>
			<INPUT TYPE="Month" STYLE="text-align: right" NAME="OperMonth" VALUE="<%=Session("OperMonth")%>" MAX="<%=Session("OperMonth")%>" DISABLED>
		</FIGCAPTION>
	</FIGURE>
	</FIELDSET>
</DIV>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn">&#9989;Виконати</BUTTON>
</FORM></BODY></HTML>