<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") >= 0 || Session("RoleId") < 2,
Title = "Новий керiвник";

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

try {
	Solaren.SetCmd("SelectChiefTitle");
	with (Cmd) {
		with (Parameters) {	
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
		}
	}
	var rsChiefTitle = Solaren.Execute("SelectChiefTitle", "Довiдник посад пустий!"),
	rsChiefDoc = Solaren.Execute("SelectChiefDoc", "Довiдник документів керівника пустий!");
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

with (Html) {
	SetHead(Title);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
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
		<TD><%Html.WriteChiefDoc(rsChiefDoc, -1); Connect.Close()%></TD></TR>

		<TR><TD ALIGN="RIGHT">Довiренiсть</TD>
		<TD><INPUT TYPE="TEXT" NAME="TrustedDocId" SIZE="10"></TD></TR>
		<TR><TD ALIGN="RIGHT">Дата</TD>
		<TD><INPUT TYPE="date" NAME="TrustedDocDate"></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>Створити</BUTTON></FORM></BODY></HTML>