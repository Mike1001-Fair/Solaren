<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

try {
	Solaren.SetCmd("SelectChief");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("Deleted", adBoolean, adParamInput, 1, 0));
		}
	}
	var rsChief = Cmd.Execute();
	Solaren.EOF(rsChief, 'Довiдник керiвникiв пустий');
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

with (Html) {
	SetHead("Службовий лист");
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindNote" TARGET="_blank" ACTION="prnnote.asp" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="hidden" NAME="ContractId" ID="ContractId" VALUE="-1">
<H3 CLASS="HeadText">Службовий лист</H3>
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<% Html.WriteContractName("", "REQUIRED") %>
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT">Перioд</TD>
	<TD><INPUT TYPE="Month" NAME="ReportMonth" VALUE="<%=Session("OperMonth")%>" MIN="<%=Html.LimitMonth(0)%>" MAX="<%=Session("OperMonth")%>" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">Керівник</TD>
	<TD><%Html.WriteChief(rsChief, -1)%></TD></TR>	
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" DISABLED>&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>