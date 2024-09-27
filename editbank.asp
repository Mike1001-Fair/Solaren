<%@ LANGUAGE="JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2,
BankId = Request.QueryString("BankId");
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

try {
	Solaren.SetCmd("GetBank");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("BankId", adInteger, adParamInput, 10, BankId));
		}
	}
	var rsBank = Cmd.Execute();
	Solaren.EOF(rsBank, 'Iнформацiю не знайдено');
	with (rsBank) {
		var EdrpoCode = Fields("EdrpoCode").value,
		MfoCode       = Fields("MfoCode").value,
		BankName      = Fields("BankName").value,
		Deleted       = Fields("Deleted").value,
		HeadTitle     = Deleted ? "Перегляд анкети банку" : "Редагування анкети банку";
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
<FORM CLASS="ValidForm" NAME="EditBank" ACTION="updatebank.asp" METHOD="POST" AUTOCOMPLETE="off">
<INPUT TYPE="HIDDEN" NAME="BankId" VALUE="<%=BankId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">

<H3 CLASS="HeadText" ID="H3Id"><SPAN>&#127974;</SPAN><%=HeadTitle%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET NAME="BankSet"><LEGEND>Параметри</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Код</TD>
	<TD><INPUT TYPE="TEXT" NAME="EdrpoCode" PLACEHOLDER="ЄДРПОУ" VALUE="<%=EdrpoCode%>" SIZE="10" MAXLENGTH="8" PATTERN="\d{8}" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">МФО</TD>
	<TD><INPUT TYPE="TEXT" NAME="MfoCode" VALUE="<%=MfoCode%>" SIZE="10" MAXLENGTH="6" PATTERN="\d{6}" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Назва</TD>
	<TD><INPUT TYPE="TEXT" NAME="BankName" PLACEHOLDER="Коротка без лапок" VALUE="<%=BankName%>" SIZE="30" MAXLENGTH="30" REQUIRED></TD></TR>
	</TABLE></FIELDSET>
	</TD></TR>
</TABLE>
<% Html.WriteEditButton(1)%>
</FORM></BODY></HTML>