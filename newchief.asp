<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Include/new.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2;
User.CheckAccess(Authorized, "GET");

try {
	Solaren.SetCmd("SelectChiefTitle");
	with (Cmd) {
		with (Parameters) {	
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
		}
	}
	var rsChiefTitle = Solaren.Execute("SelectChiefTitle", "Довiдник посад пустий!"),
	rsChiefDoc = Solaren.Execute("SelectChiefDoc", "Довiдник документів керівника пустий!");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}

Html.SetPage("Новий керiвник")%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewChief" METHOD="post" ACTION="createchief.asp" AUTOCOMPLETE="off">
<H3 CLASS="HeadText"><SPAN>&#128100;</SPAN><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD><FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE>
		<TR><TD ALIGN="RIGHT">Посада</TD>
		<TD><%Html.WriteChiefTitle(rsChiefTitle, -1)%></TD></TR>

		<TR><TD ALIGN="RIGHT">Хто?</TD>
		<TD><INPUT TYPE="TEXT" NAME="Name1" PLACEHOLDER="ПІБ" SIZE="30" MAXLENGTH="30"  REQUIRED></TD></TR>
		<TR><TD ALIGN="RIGHT">Кого?</TD>
		<TD><INPUT TYPE="TEXT" NAME="Name2" PLACEHOLDER="ПІБ" SIZE="30" MAXLENGTH="30" REQUIRED></TD></TR>
		<TR><TD ALIGN="RIGHT">Кому?</TD>
		<TD><INPUT TYPE="TEXT" NAME="Name3" PLACEHOLDER="ПІБ" SIZE="30" MAXLENGTH="30" REQUIRED></TD></TR>

		<TR><TD ALIGN="RIGHT">Документ</TD>
		<TD><%Html.WriteChiefDoc(rsChiefDoc, -1); Solaren.Close()%></TD></TR>

		<TR><TD ALIGN="RIGHT">Довiренiсть</TD>
		<TD><INPUT TYPE="TEXT" NAME="TrustedDocId" SIZE="10"></TD></TR>
		<TR><TD ALIGN="RIGHT">Дата</TD>
		<TD><INPUT TYPE="date" NAME="TrustedDocDate"></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>Створити</BUTTON></FORM></BODY></HTML>


