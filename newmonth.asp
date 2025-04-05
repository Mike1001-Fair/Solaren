<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1,
OperMonth = Month.GetMonth(1);

User.ValidateAccess(Authorized, "GET");
Html.SetPage("Закриття мicяця")%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewMonth" ACTION="runmonthclosing.asp" METHOD="post">
<H3 CLASS="HeadText"><%=Html.Title%></H3>
<DIV CLASS="SysMsg">
	<FIELDSET>
	<LEGEND>Перioд</LEGEND>
	<FIGURE>
		<IMG SRC="Images/cycle.png">
		<FIGCAPTION>
			<INPUT TYPE="Month" STYLE="text-align: right" NAME="OperMonth" VALUE="<%=OperMonth%>" MAX="<%=OperMonth%>" DISABLED>
		</FIGCAPTION>
	</FIGURE>
	</FIELDSET>
</DIV>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn">&#9989;Виконати</BUTTON>
</FORM></BODY></HTML>

