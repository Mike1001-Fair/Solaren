<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/edit.set" -->

<% var Authorized = User.RoleId == 1,
AenId = Request.QueryString("AenId");
User.CheckAccess(Authorized, "GET");

try {
	Solaren.SetCmd("GetAen");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("AenId", adInteger, adParamInput, 10, AenId));
		}
	}
	var rs = Cmd.Execute();
	with (rs) {
		var SortCode = Fields("SortCode").Value,
		AenName      = Fields("AenName").Value,
		Deleted      = Fields("Deleted").Value,
		Title        = Deleted ? "Перегляд анкети РЕМ" : "Редагування анкети РЕМ";
		Close();
	} Solaren.Close();
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}

Html.SetPage(Title)%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditAen" ACTION="updateaen.asp" METHOD="POST">
<INPUT TYPE="HIDDEN" NAME="AenId" VALUE="<%=AenId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">
<H3 CLASS="HeadText"><%=Html.Title%></H3>
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


