<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/locality.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
Query = Solaren.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("GetLocality");
	with (Cmd) {
		Parameters.Append(CreateParameter("LocalityId", adInteger, adParamInput, 10, Query.LocalityId));
	}
	var rs = Solaren.Execute("GetLocality");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	var Record = Solaren.Map(rs.Fields);
	rs.Close();
	Solaren.Close();
	Resource.Load(User.ResourceFile());
	Html.SetPage(Record.Deleted ? "Перегляд анкети" : "Редагування анкети");
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditLocality" ACTION="updatelocality.asp" METHOD="POST" AUTOCOMPLETE="off">
<H3 CLASS="HeadText"><SPAN>&#127969;</SPAN><%=Html.Title%></H3>
<INPUT TYPE="HIDDEN" NAME="LocalityId" VALUE="<%=Query.LocalityId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Record.Deleted%>">
<TABLE CLASS="MarkupTable">
	<TR ALIGN="CENTER"><TD>
	<FIELDSET NAME="LocalitySet"><LEGEND>Параметри</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Тип</TD>
	<TD><%Locality.WriteType("LocalityType", Record.LocalityType)%></TD></TR>
	<TR><TD ALIGN="RIGHT">Назва</TD>
	<TD><INPUT TYPE="TEXT" NAME="LocalityName" VALUE="<%=Record.LocalityName%>" SIZE="30" MAXLENGTH="30" REQUIRED></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<% Html.WriteEditButton(1, Record.Deleted)%>
</FORM></BODY></HTML>


