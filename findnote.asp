<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Include/find.inc" -->
<% var Authorized = User.RoleId == 1;
User.CheckAccess(Authorized, "GET");

try {
	Solaren.SetCmd("SelectChief");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
		}
	}
	var rs = Solaren.Execute("SelectChief");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}

Html.SetPage("Службовий лист")%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindNote" TARGET="_blank" ACTION="prnnote.asp" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="hidden" NAME="ContractId" ID="ContractId" VALUE="-1">
<H3 CLASS="HeadText"><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<% Html.WriteSearchSet("Договір", "Contract", "", 1) %>
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT">Перioд</TD>
	<TD><INPUT TYPE="Month" NAME="ReportMonth" VALUE="<%=Month.GetMonth(1)%>" MIN="<%=Month.GetMonth(0)%>" MAX="<%=Month.GetMonth(1)%>" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">Керівник</TD>
	<TD><%Html.WriteSelect(rs, "Chief", 0, -1);
	Solaren.Close()%></TD></TR>	
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" DISABLED>&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>



