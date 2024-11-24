<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

try {
	Solaren.SetCmd("SelectChief");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 3, Session("UserId")));
		}
	}
	var rsChief = Cmd.Execute();
	Solaren.EOF(rsChief, 'Довiдник керiвникiв пустий');
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
} finally {
	with (Html) {
		SetHead("Компенсація");
		WriteScript();
		WriteMenu(Session("RoleId"), 0);
	}
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindCompensation" ACTION="prncompensation.asp" TARGET="_blank" METHOD="post" AUTOCOMPLETE="off">
<H3 CLASS="HeadText">Компенсація</H3>
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET><LEGEND ALIGN="CENTER">Параметри</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT">Перiод</TD>
	<TD><INPUT TYPE="Month" NAME="ReportMonth" VALUE="<%=Session("OperMonth")%>" MIN="2015-01" MAX="<%=Session("OperMonth")%>" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">Ціна</TD>
	<TD><INPUT TYPE="Number" NAME="AveragePrice" VALUE="1" STEP="0.000001" MIN="0" MAX="99999" REQUIRED AUTOFOCUS PLACEHOLDER="коп">
	<TR><TD ALIGN="RIGHT">Керівник</TD>
	<TD><%Html.WriteSelect(rsChief, "Chief", 0, -1);
	Connect.Close()%></TD></TR>

	</TABLE></FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn">&#128270;Пошук</BUTTON></FORM></BODY></HTML>