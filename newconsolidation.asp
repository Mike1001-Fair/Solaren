<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/referer.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = User.RoleId == 1,
OperMonth = Month.GetMonth(1);

if (User.ValidateAccess(Authorized, "GET")) {
	Html.SetPage("Консолiдацiя")
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="Consolidation" ACTION="runconsolidation.asp" METHOD="post">
<H3 CLASS="HeadText"><%=Html.Title%></H3>
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




