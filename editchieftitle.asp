<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/edit.set" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
Query = Webserver.Parse();
User.CheckAccess(Authorized, "GET");

try {
	Solaren.SetCmd("GetChiefTitle");
	with (Cmd) {      
		Parameters.Append(CreateParameter("ChiefTitleId", adInteger, adParamInput, 10, Query.ChiefTitleId));
	}
	var rs = Solaren.Execute("GetChiefTitle");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	var Record = Webserver.Map(rs.Fields),
	Title = Record.Deleted ? "Перегляд документу" : "Редагування документу";
	rs.Close();
	Solaren.Close();
	Html.SetPage(Title);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditChiefTitle" ACTION="updatechieftitle.asp" METHOD="POST" AUTOCOMPLETE="off">
<H3 CLASS="HeadText"><%=Html.Title%></H3>
<INPUT TYPE="HIDDEN" NAME="ChiefTitleId" VALUE="<%=Query.ChiefTitleId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Record.Deleted%>">
<TABLE CLASS="MarkupTable">
	<TR ALIGN="CENTER"><TD>
	<FIELDSET NAME="ChiefTitleSet"><LEGEND>Параметри</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Хто?</TD>
	<TD><INPUT TYPE="TEXT" NAME="Title1" VALUE="<%=Record.Title1%>" SIZE="30" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Кого?</TD>
	<TD><INPUT TYPE="TEXT" NAME="Title2" VALUE="<%=Record.Title2%>" SIZE="30" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Кому?</TD>
	<TD><INPUT TYPE="TEXT" NAME="Title3" VALUE="<%=Record.Title3%>" SIZE="30" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Ранг</TD>
	<TD><INPUT TYPE="Number" NAME="RankId" VALUE="<%=Record.RankId%>" MIN="1" MAX="4" TITLE="1-найвища посада" REQUIRED></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<% Html.WriteEditButton(1, Record.Deleted)%>
</FORM></BODY></HTML>