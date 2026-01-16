<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/edit.set" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
Query = Webserver.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Db.SetCmd("GetStreet");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("StreetId", adInteger, adParamInput, 10, Query.StreetId));
		}
	}
	var rs = Db.Execute("GetStreet");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	var Record = Webserver.Map(rs.Fields);
	rs.Close();
	Db.Close();
	Html.SetPage(Record.Deleted ? "Перегляд вулицi" : "Редагування вулицi");
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditStreet" ACTION="updatestreet.asp" METHOD="POST" AUTOCOMPLETE="off">
<H3 CLASS="HeadText"><SPAN>&#128678;</SPAN><%=Html.Title%></H3>
<INPUT TYPE="HIDDEN" NAME="StreetId" VALUE="<%=Query.StreetId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Record.Deleted%>">
<TABLE CLASS="MarkupTable">
	<TR ALIGN="CENTER"><TD>
	<FIELDSET NAME="StreetSet"><LEGEND>Параметри</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Тип</TD>
	<TD><%Street.WriteType("StreetType", Record.StreetType)%></TD></TR>
	<TR><TD>Назва</TD>
	<TD><INPUT TYPE="TEXT" NAME="StreetName" VALUE="<%=Record.StreetName%>" SIZE="30" MAXLENGTH="30" REQUIRED></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<% Html.WriteEditButton(1, Record.Deleted)%>
</FORM></BODY></HTML>