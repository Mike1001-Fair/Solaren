<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
ChiefTitleId = Request.QueryString("ChiefTitleId");
User.ValidateAccess(Authorized, "GET");

try {
	Solaren.SetCmd("GetChiefTitle");
	with (Cmd) {      
		Parameters.Append(CreateParameter("ChiefTitleId", adInteger, adParamInput, 10, ChiefTitleId));
	}
	var rs = Solaren.Execute("GetChiefTitle");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	with (rs) {
		var Title1 = Fields("Title1").value,
		Title2     = Fields("Title2").value,
		Title3     = Fields("Title3").value,
		RankId     = Fields("RankId").value,
		Deleted    = Fields("Deleted").value,
		Title      = Deleted ? "Перегляд посади" : "Редагування посади";
		Close();
	}
	Solaren.Close();
	Html.SetPage(Title);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditChiefTitle" ACTION="updatechieftitle.asp" METHOD="POST" AUTOCOMPLETE="off">
<H3 CLASS="HeadText"><%=Html.Title%></H3>
<INPUT TYPE="HIDDEN" NAME="ChiefTitleId" VALUE="<%=ChiefTitleId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">
<TABLE CLASS="MarkupTable">
	<TR ALIGN="CENTER"><TD>
	<FIELDSET NAME="ChiefTitleSet"><LEGEND>Параметри</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Хто?</TD>
	<TD><INPUT TYPE="TEXT" NAME="Title1" VALUE="<%=Title1%>" SIZE="30" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Кого?</TD>
	<TD><INPUT TYPE="TEXT" NAME="Title2" VALUE="<%=Title2%>" SIZE="30" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Кому?</TD>
	<TD><INPUT TYPE="TEXT" NAME="Title3" VALUE="<%=Title3%>" SIZE="30" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Ранг</TD>
	<TD><INPUT TYPE="Number" NAME="RankId" VALUE="<%=RankId%>" MIN="1" MAX="4" TITLE="1-найвища посада" REQUIRED></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<% Html.WriteEditButton(1)%>
</FORM></BODY></HTML>

