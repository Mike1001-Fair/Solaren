<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% Resource.Load(User.ResourceFile());

var RoleId = Session("RoleId"),
Authorized = RoleId >= 0 && RoleId < 2,
LocalityId = Request.QueryString("LocalityId");

if (!Authorized) {
	Solaren.SysMsg(2, Dictionary.Item("AuthorizationError"));
}

try {
	Solaren.SetCmd("GetLocality");
	with (Cmd) {
		Parameters.Append(CreateParameter("LocalityId", adInteger, adParamInput, 10, LocalityId));
	}
	var rs = Solaren.Execute("GetLocality", "Iнформацiю не знайдено");
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
} finally {
	with (rs) {
		var LocalityType = Fields("LocalityType").value,
		LocalityName     = Fields("LocalityName").value,
		Deleted          = Fields("Deleted").value,
		Title            = Deleted ? "Перегляд населеного пункту" : "Редагування населеного пункту";
		Close();
	}
	Connect.Close();
	Html.SetPage(Title, RoleId)
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditLocality" ACTION="updatelocality.asp" METHOD="POST" AUTOCOMPLETE="off">
<H3 CLASS="HeadText"><SPAN>&#127969;</SPAN><%=Html.Title%></H3>
<INPUT TYPE="HIDDEN" NAME="LocalityId" VALUE="<%=LocalityId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">
<TABLE CLASS="MarkupTable">
	<TR ALIGN="CENTER"><TD>
	<FIELDSET NAME="LocalitySet"><LEGEND>Параметри</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Тип</TD>
	<TD><%Html.WriteLocalityType("LocalityType", LocalityType)%></TD></TR>
	<TR><TD ALIGN="RIGHT">Назва</TD>
	<TD><INPUT TYPE="TEXT" NAME="LocalityName" VALUE="<%=LocalityName%>" SIZE="30" MAXLENGTH="30" REQUIRED></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<% Html.WriteEditButton(1)%>
</FORM></BODY></HTML>