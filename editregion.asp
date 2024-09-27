<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2,
RegionId = Request.QueryString("RegionId");
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

try {
	Solaren.SetCmd("GetRegion");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("RegionId", adInteger, adParamInput, 10, RegionId));
		}
	}
	var rs = Cmd.Execute();
	with (rs) {
	    var SortCode   = Fields("SortCode").value,
		RegionName = Fields("RegionName").value,
		Deleted    = Fields("Deleted").value,
		HeadTitle  = Deleted ? "Перегляд області" : "Редагування області";
		Close();
	}
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
} finally {
	Connect.Close();
}

with (Html) {
	SetHead(HeadTitle);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditRegion" ACTION="updateregion.asp" METHOD="POST" AUTOCOMPLETE="off">
<H3 CLASS="HeadText" ID="H3Id"><%=HeadTitle%></H3>
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