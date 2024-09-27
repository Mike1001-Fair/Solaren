<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2,
ChiefTitleId = Request.QueryString("ChiefTitleId");

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

try {
	Solaren.SetCmd("GetChiefTitle");
	with (Cmd) {      
		Parameters.Append(CreateParameter("ChiefTitleId", adInteger, adParamInput, 10, ChiefTitleId));
	}
	var rs = Cmd.Execute();
	with (rs) {
		var Title1 = Fields("Title1").value,
		Title2     = Fields("Title2").value,
		Title3     = Fields("Title3").value,
		RankId     = Fields("RankId").value,
		Deleted    = Fields("Deleted").value,
		Title      = Deleted ? "Перегляд посади" : "Редагування посади";
		Close();
	}
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
} finally {
	Connect.Close();
}

with (Html) {
	SetHead(Title);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditChiefTitle" ACTION="updatechieftitle.asp" METHOD="POST" AUTOCOMPLETE="off">
<H3 CLASS="HeadText"><%=Title%></H3>
<SPAN CLASS="H3Span">керівника</SPAN>
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