<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/edit.set" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
Query = Solaren.Parse();
User.CheckAccess(Authorized, "GET");

try {
	Solaren.SetCmd("SelectChiefTitle");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 3, User.Id));
		}
	}
	var rsChiefTitle = Solaren.Execute("SelectChiefTitle", "Довiдник посад пустий!"),
	rsChiefDoc = Solaren.Execute("SelectChiefDoc", "Довiдник документів керівника пустий!");

	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("ChiefId", adInteger, adParamInput, 10, Query.ChiefId));
		}
	}
	var rsChief = Solaren.Execute("GetChief", "Керівника не знайдено!");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	var Record = Solaren.Map(rsChief.Fields);
	rsChief.Close();
	Html.SetPage(Record.Deleted ? "Перегляд анкети" : "Редагування анкети");
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditChief" ACTION="updatechief.asp" METHOD="POST" AUTOCOMPLETE="off">
<H3 CLASS="HeadText"><%=Html.Title%></H3>

<INPUT TYPE="HIDDEN" NAME="ChiefId" VALUE="<%=Query.ChiefId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Record.Deleted%>">
<TABLE CLASS="MarkupTable">
	<TR ALIGN="CENTER"><TD>
	<FIELDSET NAME="ChiefSet"><LEGEND>Параметри</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Посада</TD>
	<TD><%Html.WriteChiefTitle(rsChiefTitle, Record.TitleId)%></TD></TR>

	<TR><TD ALIGN="RIGHT">Хто?</TD>
	<TD><INPUT TYPE="TEXT" NAME="Name1" PLACEHOLDER="ПІБ" VALUE="<%=Record.Name1%>" SIZE="30" MAXLENGTH="30" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Кого?</TD>
	<TD><INPUT TYPE="TEXT" NAME="Name2" PLACEHOLDER="ПІБ" VALUE="<%=Record.Name2%>" SIZE="30" MAXLENGTH="30" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Кому?</TD>
	<TD><INPUT TYPE="TEXT" NAME="Name3" PLACEHOLDER="ПІБ" VALUE="<%=Record.Name3%>" SIZE="30" MAXLENGTH="30" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">Документ</TD>
	<TD><%Html.WriteChiefDoc(rsChiefDoc, Record.ChiefDocId)%></TD></TR>

	<TR><TD ALIGN="RIGHT">Довiренiсть</TD>
	<TD><INPUT TYPE="TEXT" NAME="TrustedDocId" VALUE="<%=Record.TrustedDocId%>" SIZE="10"></TD></TR>
	<TR><TD ALIGN="RIGHT">Дата</TD>
	<TD><INPUT TYPE="date" NAME="TrustedDocDate" VALUE="<%=Record.TrustedDocDate%>"></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<% Solaren.Close();
Html.WriteEditButton(1, Record.Deleted)%>
</FORM></BODY></HTML>


