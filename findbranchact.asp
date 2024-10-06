<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

try {
	Solaren.SetCmd("SelectBranch");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 3, Session("UserId")));
		}
	}
	var rsBranch = Cmd.Execute();
	Solaren.EOF(rsBranch, 'Довiдник ЦОС пустий');
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

with (Html) {
	SetHead("Перевірка актів");
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindBranchAct" ACTION="listbranchact.asp" METHOD="post" TARGET="_blank">
<INPUT TYPE="HIDDEN" NAME="BranchName">
<H3 CLASS="HeadText">Перевірка актів</H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<% Html.WriteMonthPeriod() %>	
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<LABEL>ЦОС
	<%Html.WriteBranch(rsBranch, -1, 0);
	Connect.Close()%>
	</LABEL></FIELDSET>	
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn">&#128270;Пошук</BUTTON></FORM></BODY></HTML>