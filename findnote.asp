<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<% var Authorized = User.RoleId == 1,
Title = "Службовий лист";
User.ValidateAccess(Authorized);

try {
	Solaren.SetCmd("SelectChief");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
		}
	}
	var rs = Solaren.Execute("SelectChief", "Iнформацiю не знайдено");
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

Html.SetPage(Title, User.RoleId)%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindNote" TARGET="_blank" ACTION="prnnote.asp" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="hidden" NAME="ContractId" ID="ContractId" VALUE="-1">
<H3 CLASS="HeadText"><%=Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<% Html.WriteSearchSet("Договір", "Contract", "", 1) %>
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT">Перioд</TD>
	<TD><INPUT TYPE="Month" NAME="ReportMonth" VALUE="<%=Html.OperMonth()%>" MIN="<%=Html.LimitMonth(0)%>" MAX="<%=Html.OperMonth()%>" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">Керівник</TD>
	<TD><%Html.WriteSelect(rs, "Chief", 0, -1)%></TD></TR>	
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" DISABLED>&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>