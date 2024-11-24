<%@LANGUAGE="JavaScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації")

try {
	Solaren.SetCmd("SelectChief");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
		}
	}
	var rsChief = Solaren.Execute("SelectChief", "Довiдник керiвникiв пустий");
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))	
}

with (Html) {
	SetHead("Реєстр");
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindRegistry" ACTION="prnregistry.asp" TARGET="_blank" METHOD="post">
<H3 CLASS="HeadText">Реєстр</H3>
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET><LEGEND ALIGN="CENTER">Параметри</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT">Перiод</TD>
	<TD><INPUT TYPE="Month" NAME="ReportMonth" VALUE="<%=Session("OperMonth")%>" MIN="<%=Html.LimitMonth(0)%>" MAX="<%=Session("OperMonth")%>" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Кiлькicть</TD>
	<TD><INPUT TYPE="number" NAME="CustomerCount" VALUE="90" STEP="1" MIN="30" MAX="999" REQUIRED>
	<TR><TD ALIGN="RIGHT">Керiвник</TD>
	<TD><%Html.WriteSelect(rsChief, "Chief", 0, -1)%></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn">&#128270;Пошук</BUTTON></FORM></BODY></HTML>