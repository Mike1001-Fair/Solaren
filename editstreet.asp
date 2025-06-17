<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/street.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
StreetId = Request.Form("StreetId");
User.ValidateAccess(Authorized, "POST");

try {
	Solaren.SetCmd("GetStreet");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("StreetId", adInteger, adParamInput, 10, StreetId));
		}
	}
	var rs = Solaren.Execute("GetStreet");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	var Record = Solaren.Map(rs.Fields);
	rs.Close();
	Solaren.Close();
	Html.SetPage(Record.Deleted ? "Перегляд вулицi" : "Редагування вулицi");
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditStreet" ACTION="updatestreet.asp" METHOD="POST" AUTOCOMPLETE="off">
<H3 CLASS="HeadText"><SPAN>&#128678;</SPAN><%=Html.Title%></H3>
<INPUT TYPE="HIDDEN" NAME="StreetId" VALUE="<%=StreetId%>">
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