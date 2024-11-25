<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") == 1,
OperMonth = Html.GetMonth(1),
Title = "Консолiдацiя";

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Html) {
	SetHead(Title);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="Consolidation" ACTION="runconsolidation.asp" METHOD="post">
<H3 CLASS="HeadText"><%=Title%></H3>
<DIV CLASS="SysMsg">
	<FIELDSET>
	<LEGEND>Перioд</LEGEND>
	<FIGURE>
		<IMG SRC="Images/consolidation.png" WIDTH="120" HEIGHT="112">
		<FIGCAPTION>
			<INPUT TYPE="Month" STYLE="text-align: right" NAME="OperMonth" VALUE="<%=OperMonth%>" MAX="<%=OperMonth%>" DISABLED>
		</FIGCAPTION>
	</FIGURE>
	</FIELDSET>
</DIV>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn">&#9989;Виконати</BUTTON>
</FORM></BODY></HTML>
