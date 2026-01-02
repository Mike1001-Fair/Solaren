<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/edit.set" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
Query = Solaren.Parse();
User.CheckAccess(Authorized, "GET");

try {
	Solaren.SetCmd("GetChiefDoc");
	with (Cmd) {
		with (Parameters) {
			Parameters.Append(CreateParameter("DocId", adInteger, adParamInput, 10, Query.DocId));
		}
	} 
	var rs = Solaren.Execute("GetChiefDoc");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	var Record = Solaren.Map(rs.Fields),
	Title = Record.Deleted ? "Перегляд документу" : "Редагування документу";
	rs.Close();
	Solaren.Close();
	Html.SetPage(Title);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditChiefDoc" ACTION="updatechiefdoc.asp" METHOD="POST">
<H3 CLASS="HeadText"><SPAN>&#128216;</SPAN><%=Html.Title%></H3>

<INPUT TYPE="HIDDEN" NAME="DocId" VALUE="<%=Query.DocId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Record.Deleted%>">
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<FIELDSET NAME="ChiefDocSet"><LEGEND>Параметри</LEGEND>
	<TABLE>
		<TR><TD ALIGN="RIGHT">№</TD>
		<TD><INPUT TYPE="Number" NAME="SortCode" VALUE="<%=Record.SortCode%>" MIN="1" MAX="255" REQUIRED></TD></TR>
		<TR><TD ALIGN="RIGHT">Назва</TD>
		<TD><INPUT TYPE="TEXT" NAME="DocName" VALUE="<%=Record.DocName%>" SIZE="30" MAXLENGTH="20" REQUIRED></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<% Html.WriteEditButton(1, Record.Deleted)%>
</FORM></BODY></HTML>


