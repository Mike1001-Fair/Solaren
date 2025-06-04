<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/referer.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
AreaId = Request.QueryString("AreaId");

User.ValidateAccess(Authorized, "POST");

try {
	Solaren.SetCmd("GetArea");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("AreaId", adInteger, adParamInput, 10, AreaId));
		}
	} 
	var rsArea = Cmd.Execute();
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	with (rsArea) {
		var SortCode = Fields("SortCode").value,
		AreaName     = Fields("AreaName").value,
		Deleted      = Fields("Deleted").value,
		Title        = Deleted ? "Перегляд анкети району" : "Редагування анкети району";
		Close();
	}
	Solaren.Close();
	Html.SetPage(Title);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditArea" ACTION="updatearea.asp" METHOD="POST" AUTOCOMPLETE="off">
<H3 CLASS="HeadText" ID="H3Id"><%=Title%></H3>
<INPUT TYPE="HIDDEN" NAME="AreaId" VALUE="<%=AreaId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">
<TABLE CLASS="MarkupTable">
	<TR ALIGN="CENTER"><TD>
	<FIELDSET NAME="AreaSet"><LEGEND>Параметри</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT">№</TD>
	<TD><INPUT TYPE="Number" NAME="SortCode" VALUE="<%=SortCode%>" MIN="1" MAX="255" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Назва</TD>
	<TD><INPUT TYPE="TEXT" NAME="AreaName" VALUE="<%=AreaName%>" SIZE="30" MAXLENGTH="20" REQUIRED></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<% Html.WriteEditButton(1)%>
</FORM></BODY></HTML>


