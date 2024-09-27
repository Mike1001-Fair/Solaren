<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") < 2,
StreetId = Request.QueryString("StreetId");

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

try {
	Solaren.SetCmd("GetStreet");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("StreetId", adInteger, adParamInput, 10, StreetId));
		}
	}
	var rsStreet = Cmd.Execute();
	with (rsStreet) {
		var StreetType = Fields("StreetType").value,
		StreetName     = Fields("StreetName").value,
		Deleted        = Fields("Deleted").value,
		HeadTitle      = Deleted ? "Перегляд вулицi" : "Редагування вулицi";
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
<FORM CLASS="ValidForm" NAME="EditStreet" ACTION="updatestreet.asp" METHOD="POST" AUTOCOMPLETE="off">
<H3 CLASS="HeadText"><SPAN>&#128678;</SPAN><%=HeadTitle%></H3>
<INPUT TYPE="HIDDEN" NAME="StreetId" VALUE="<%=StreetId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">
<TABLE CLASS="MarkupTable">
	<TR ALIGN="CENTER"><TD>
	<FIELDSET NAME="StreetSet"><LEGEND>Параметри</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Тип</TD>
	<TD><%Html.WriteStreetType("StreetType", StreetType)%></TD></TR>
	<TR><TD>Назва</TD>
	<TD><INPUT TYPE="TEXT" NAME="StreetName" VALUE="<%=StreetName%>" SIZE="30" MAXLENGTH="30" REQUIRED></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<% Html.WriteEditButton(1)%>
</FORM></BODY></HTML>