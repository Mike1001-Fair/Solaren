<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") == 1,
Title = "Обсяги";
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

try {
	Solaren.SetCmd("SelectContract");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("Deleted", adBoolean, adParamInput, 1, 0));
		}
	}
	var rs = Cmd.Execute();
	Solaren.EOF(rs, "Довiдник договорів пустий!");
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex));
}

with (Html) {
	SetHead(Title);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindVol" ACTION="listvol.asp" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="hidden" NAME="ContractId" ID="ContractId" VALUE="-1">
<H3 CLASS="HeadText"><%=Title%></H3>

<TABLE CLASS="MarkupTable">
       	<TR><TD ALIGN="CENTER">
	<% with (Html) {
		WriteMonthPeriod();
		WriteContractName("", "REQUIRED");
	} %>
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>&#128270;Пошук</BUTTON></FORM></BODY></HTML>