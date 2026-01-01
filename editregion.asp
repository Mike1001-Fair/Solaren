<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Include/edit.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
RegionId = Request.QueryString("RegionId");

User.CheckAccess(Authorized, "GET");

try {
	Solaren.SetCmd("GetRegion");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("RegionId", adInteger, adParamInput, 10, RegionId));
		}
	}
	var rs = Solaren.Execute("GetRegion");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	with (rs) {
		var SortCode = Fields("SortCode").Value,
		RegionName   = Fields("RegionName").Value,
		Deleted      = Fields("Deleted").Value,
		Title        = Deleted ? "Перегляд області" : "Редагування області";
		Close();
	}
	Solaren.Close();
	Html.SetPage(Title);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditRegion" ACTION="updateregion.asp" METHOD="POST" AUTOCOMPLETE="off">
<H3 CLASS="HeadText" ID="H3Id"><%=Html.Title%></H3>
<INPUT TYPE="HIDDEN" NAME="RegionId" VALUE="<%=RegionId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET NAME="RegionSet"><LEGEND>Параметри</LEGEND>
	<TABLE>
		<TR><TD ALIGN="RIGHT">№</TD>
		<TD><INPUT TYPE="Number" NAME="SortCode" VALUE="<%=SortCode%>" MIN="1" MAX="255" REQUIRED></TD></TR>
		<TR><TD ALIGN="RIGHT">Назва</TD>
		<TD><INPUT TYPE="TEXT" NAME="RegionName" VALUE="<%=RegionName%>" SIZE="30" MAXLENGTH="20" REQUIRED></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<% Html.WriteEditButton(1)%>
</FORM></BODY></HTML>


