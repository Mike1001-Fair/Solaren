<%@LANGUAGE="JavaScript"%>
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1;
User.ValidateAccess(Authorized, "GET")
Html.SetPage("Кiлькiсть договорiв", User.RoleId)%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindContractNumber" ACTION="listcontractnumber.asp" METHOD="post" TARGET="_blank">
<H3 CLASS="HeadText"><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<LABEL>Станом на
		<INPUT TYPE="date" NAME="ReportDate" VALUE="<%=Month.Date[1]%>" MIN="<%=Month.Date[0]%>" MAX="<%=Month.Date[2]%>" REQUIRED>
	</LABEL>
	</FIELDSET>
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn">&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>
