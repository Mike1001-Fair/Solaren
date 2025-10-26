<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
DocId = Request.QueryString("DocId");
User.CheckAccess(Authorized, "GET");

try {
	Solaren.SetCmd("GetChiefDoc");
	with (Cmd) {
		with (Parameters) {
			Parameters.Append(CreateParameter("DocId", adInteger, adParamInput, 10, DocId));
		}
	} 
	var rs = Solaren.Execute("GetChiefDoc");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	with (rs) {
		var SortCode = Fields("SortCode").value,
		DocName      = Fields("DocName").value,
		Deleted      = Fields("Deleted").value,
		Title        = Deleted ? "Перегляд документу" : "Редагування документу";
		Close();
	} Solaren.Close();
	Html.SetPage(Title);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditChiefDoc" ACTION="updatechiefdoc.asp" METHOD="POST">
<H3 CLASS="HeadText"><SPAN>&#128216;</SPAN><%=Html.Title%></H3>

<INPUT TYPE="HIDDEN" NAME="DocId" VALUE="<%=DocId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<FIELDSET NAME="ChiefDocSet"><LEGEND>Параметри</LEGEND>
	<TABLE>
		<TR><TD ALIGN="RIGHT">№</TD>
		<TD><INPUT TYPE="Number" NAME="SortCode" VALUE="<%=SortCode%>" MIN="1" MAX="255" REQUIRED></TD></TR>
		<TR><TD ALIGN="RIGHT">Назва</TD>
		<TD><INPUT TYPE="TEXT" NAME="DocName" VALUE="<%=DocName%>" SIZE="30" MAXLENGTH="20" REQUIRED></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<% Html.WriteEditButton(1)%>
</FORM></BODY></HTML>


