<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/edit.set" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
Query = Webserver.Parse();
User.CheckAccess(Authorized, "GET");

try {
	Solaren.SetCmd("GetRegion");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("RegionId", adInteger, adParamInput, 10, Query.RegionId));
		}
	}
	var rs = Solaren.Execute("GetRegion");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	var Record = Webserver.Map(rs.Fields),
	Title = Record.Deleted ? "Перегляд області" : "Редагування області";
	rs.Close();
	Solaren.Close();
	Html.SetPage(Title);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditRegion" ACTION="updateregion.asp" METHOD="POST" AUTOCOMPLETE="off">
<H3 CLASS="HeadText" ID="H3Id"><%=Html.Title%></H3>
<INPUT TYPE="HIDDEN" NAME="RegionId" VALUE="<%=Query.RegionId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Record.Deleted%>">
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET NAME="RegionSet"><LEGEND>Параметри</LEGEND>
	<TABLE>
		<TR><TD ALIGN="RIGHT">№</TD>
		<TD><INPUT TYPE="Number" NAME="SortCode" VALUE="<%=Record.SortCode%>" MIN="1" MAX="255" REQUIRED></TD></TR>
		<TR><TD ALIGN="RIGHT">Назва</TD>
		<TD><INPUT TYPE="TEXT" NAME="RegionName" VALUE="<%=Record.RegionName%>" SIZE="30" MAXLENGTH="20" REQUIRED></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<% Html.WriteEditButton(1, Record.Deleted)%>
</FORM></BODY></HTML>