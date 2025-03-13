<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->

<% var Authorized = User.RoleId == 1;
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
	Html.SetPage("Компенсація", User.RoleId)
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindCompensation" ACTION="prncompensation.asp" TARGET="_blank" METHOD="post" AUTOCOMPLETE="off">
<H3 CLASS="HeadText">Компенсація</H3>
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET><LEGEND ALIGN="CENTER">Параметри</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT">Перiод</TD>
	<TD><INPUT TYPE="Month" NAME="ReportMonth" VALUE="<%=Month.GetMonth(1)%>" MIN="2015-01" MAX="<%=Month.GetMonth(1)%>" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">Ціна</TD>
	<TD><INPUT TYPE="Number" NAME="AveragePrice" VALUE="1" STEP="0.000001" MIN="0" MAX="99999" REQUIRED AUTOFOCUS PLACEHOLDER="коп">
	<TR><TD ALIGN="RIGHT">Керівник</TD>
	<TD><%Html.WriteSelect(rs, "Chief", 0, -1);
	Solaren.Close()%></TD></TR>

	</TABLE></FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn">&#128270;Пошук</BUTTON></FORM></BODY></HTML>
