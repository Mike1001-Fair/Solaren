<%@LANGUAGE="JavaScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->

<% var Authorized = User.RoleId == 1,
OperMonth = Month.GetMonth(1);
User.ValidateAccess(Authorized, "GET")

try {
	Solaren.SetCmd("SelectChief");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
		}
	}
	var rs = Solaren.Execute("SelectChief", "Довiдник керiвникiв пустий");
} catch (ex) {
	Message.Write(3, Message.Error(ex))	
} finally {
	Html.SetPage("Реєстр")
}%>

<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindRegistry" ACTION="prnregistry.asp" TARGET="_blank" METHOD="post">
<H3 CLASS="HeadText">Реєстр</H3>
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET><LEGEND ALIGN="CENTER">Параметри</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT">Перiод</TD>
	<TD><INPUT TYPE="Month" NAME="ReportMonth" VALUE="<%=OperMonth%>" MIN="<%=OperMonth%>" MAX="<%=OperMonth%>" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Кiлькicть</TD>
	<TD><INPUT TYPE="number" NAME="CustomerCount" VALUE="80" STEP="1" MIN="30" MAX="999" REQUIRED>
	<TR><TD ALIGN="RIGHT">Керiвник</TD>
	<TD><%Html.WriteSelect(rs, "Chief", 0, -1)%></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn">&#128270;Пошук</BUTTON></FORM></BODY></HTML>
