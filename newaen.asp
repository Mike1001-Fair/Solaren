<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2;
if (!Authorized) Message.Write(2, "Помилка авторизації");
try {
	Solaren.SetCmd("GetAenSortCode");
	with (Cmd) {
		with (Parameters) {	
			Append(CreateParameter("SortCode", adTinyInt, adParamOutput, 10, 0));
		} Execute(adExecuteNoRecords);
	} Solaren.Close();
	var SortCode =++ Cmd.Parameters.Item("SortCode").value;
	with (Html) {
		SetHead("Новий РЕМ");
		Menu.Write(Session("RoleId"), 0);
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}%>

<SCRIPT>
function LoadForm() {
	NewAen.AenName.focus();
}

function SbmForm() {
	let Confirmed = confirm("Ви впевненi\u2753");
	if (Confirmed) {
		NewAen.AenName.value = NewAen.AenName.value.trim();
	} return Confirmed
}

function ChkForm() {
	with (NewAen) {
		SbmBtn.disabled = !AenName.validity.valid
	}
}
</SCRIPT>

<BODY CLASS="MainBody" ONLOAD="LoadForm()">
<FORM CLASS="ValidForm" NAME="NewAen" ACTION="createaen.asp" METHOD="post" AUTOCOMPLETE="off" ONINPUT="ChkForm()">
<H3 CLASS="HeadText">Новий РЕМ</H3>
<TABLE CLASS="MarkupTable">
	<TR ALIGN="CENTER"><TD>
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">№</TD>
	<TD><INPUT TYPE="Number" NAME="SortCode" VALUE="<%=SortCode%>" MIN="1" MAX="255" READONLY></TD></TR>
	<TR ALIGN="RIGHT"><TD>Назва</TD>
	<TD><INPUT TYPE="TEXT" NAME="AenName" SIZE="30" MAXLENGTH="20" REQUIRED></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ONCLICK="return SbmForm()" DISABLED>Створити</BUTTON></FORM></BODY></HTML>


