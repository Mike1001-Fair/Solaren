<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

var AenId = Request.QueryString("AenId");

try {
	Solaren.SetCmd("GetAen");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("AenId", adInteger, adParamInput, 10, AenId));
		}
	}
	var rs = Cmd.Execute();
	with (rs) {
		var SortCode = Fields("SortCode").value,
		AenName      = Fields("AenName").value,
		Deleted      = Fields("Deleted").value,
		HeadTitle    = Deleted ? "Перегляд анкети РЕМ" : "Редагування анкети РЕМ";
		Close();
	} Connect.Close();
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

with (Html) {
	SetHead(HeadTitle);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditAen" ACTION="updateaen.asp" METHOD="POST">
<INPUT TYPE="HIDDEN" NAME="AenId" VALUE="<%=AenId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">
<H3 CLASS="HeadText"><%=HeadTitle%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET><LEGEND ALIGN="CENTER">Параметри</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT">№</TD>
	<TD><INPUT TYPE="Number" NAME="SortCode" VALUE="<%=SortCode%>" MIN="1" MAX="99" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Назва</TD>
	<TD><INPUT TYPE="TEXT" NAME="AenName" VALUE="<%=AenName%>" SIZE="30" MAXLENGTH="30" AUTOFOCUS REQUIRED></TD></TR>
	</TABLE></FIELDSET>
	</TD></TR>
</TABLE>
<% Html.WriteEditButton(1)%>
</FORM></BODY></HTML>