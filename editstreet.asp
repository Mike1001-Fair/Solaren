<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/street.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
StreetId = Request.QueryString("StreetId");

User.ValidateAccess(Authorized, "POST");

try {
	Solaren.SetCmd("GetStreet");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("StreetId", adInteger, adParamInput, 10, StreetId));
		}
	}
	var rsStreet = Solaren.Execute("GetStreet");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	with (rsStreet) {
		var StreetType = Fields("StreetType").value,
		StreetName     = Fields("StreetName").value,
		Deleted        = Fields("Deleted").value,
		Title      = Deleted ? "Перегляд вулицi" : "Редагування вулицi";
		Close();
	}
	Solaren.Close();
	Html.SetPage(Title);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditStreet" ACTION="updatestreet.asp" METHOD="POST" AUTOCOMPLETE="off">
<H3 CLASS="HeadText"><SPAN>&#128678;</SPAN><%=Html.Title%></H3>
<INPUT TYPE="HIDDEN" NAME="StreetId" VALUE="<%=StreetId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">
<TABLE CLASS="MarkupTable">
	<TR ALIGN="CENTER"><TD>
	<FIELDSET NAME="StreetSet"><LEGEND>Параметри</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Тип</TD>
	<TD><%Street.WriteType("StreetType", StreetType)%></TD></TR>
	<TR><TD>Назва</TD>
	<TD><INPUT TYPE="TEXT" NAME="StreetName" VALUE="<%=StreetName%>" SIZE="30" MAXLENGTH="30" REQUIRED></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<% Html.WriteEditButton(1)%>
</FORM></BODY></HTML>
