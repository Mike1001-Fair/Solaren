<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") == 1,
PerformerId = Request.QueryString("PerformerId");

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

try {
	Solaren.SetCmd("GetPerformer");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("PerformerId", adInteger, adParamInput, 10, PerformerId));
		}
	}
	var rs = Cmd.Execute();
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

with (rs) {
    var LastName   = Fields("LastName").value,
	FirstName  = Fields("FirstName").value,
	MiddleName = Fields("MiddleName").value,
	Phone      = Fields("Phone").value,
	HeadTitle  = "Редагування анкети виконавця";
	Close();
} Connect.Close();

with (Html) {
	SetHead(HeadTitle);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditPerformer" ACTION="updateperformer.asp" METHOD="POST">
<H3 CLASS="HeadText"><%=HeadTitle%></H3>
<INPUT TYPE="HIDDEN" NAME="PerformerId" VALUE="<%=PerformerId%>">
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Прiзвище</TD>
	<TD><INPUT TYPE="TEXT" NAME="LastName" VALUE="<%=LastName%>" SIZE="20" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Iм'я</TD>
	<TD><INPUT TYPE="TEXT" NAME="FirstName" VALUE="<%=FirstName%>" SIZE="20" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">По батьковi</TD>
	<TD><INPUT TYPE="TEXT" NAME="MiddleName" VALUE="<%=MiddleName%>" SIZE="20" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Телефон</TD>
	<TD><INPUT TYPE="phone" NAME="Phone" VALUE="<%=Phone%>" SIZE="10" MAXLENGTH="10" REQUIRED></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn">&#128190;Зберегти</BUTTON></FORM></BODY></HTML>