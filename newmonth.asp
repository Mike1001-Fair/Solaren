<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/new.set" -->
<% var Authorized = User.RoleId == 1,
OperMonth = Month.GetMonth(1);

User.CheckAccess(Authorized, "GET");
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


