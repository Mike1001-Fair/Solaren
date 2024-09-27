<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

try {
	Solaren.SetCmd("SelectContract");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("Deleted", adBoolean, adParamInput, 1, 0));
		}
	}
	var rs = Cmd.Execute();
	Solaren.EOF(rs, "Довiдник договорів пустий!");
	with (Html) {
		SetHead("Новий обсяг");
		WriteMenu(Session("RoleId"), 0);
	}
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex));
}%>

<SCRIPT>
function ChkForm() {
	with (NewFactVol) {
		let elm    = document.getElementById("SaldoId"),
		retvol     = parseInt(RetVol.value, 10),
		recvol     = parseInt(RecVol.value, 10),
		saldo      = recvol - retvol,
		notsaldo   = isNaN(saldo) || (retvol==0 && recvol==0);
		Saldo.value = isNaN(saldo) ? "" : Math.abs(saldo);
		EndDate.min = BegDate.value;
		SbmBtn.disabled = !BegDate.validity.valid || !EndDate.validity.valid || !RecVol.validity.valid || !RetVol.validity.valid || notsaldo;
		elm.textContent = (notsaldo || !saldo) ? "Сальдо" : saldo > 0 ? "Продаж" : "Покупка";
	}
}

function SbmForm() {
	let Confirmed = confirm("Ви впевненi\u2753");
	return Confirmed;
}
</SCRIPT>

<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewFactVol" ACTION="createfactvol.asp" METHOD="post" ONINPUT="ChkForm()">
<H3 CLASS="HeadText">Новий обсяг</H3>
<TABLE CLASS="MarkupTable">
       	<TR><TD ALIGN="CENTER">
	<FIELDSET><LEGEND>Перioд</LEGEND>
	<INPUT TYPE="date" NAME="BegDate" VALUE="<%=Session("OperDate")%>" MIN="<%=Session("OperDate")%>" MAX="<%=Session("EndDate")%>" REQUIRED> &#8722;
	<INPUT TYPE="date" NAME="EndDate" VALUE="<%=Session("EndDate")%>" MIN="<%=Session("OperDate")%>" MAX="<%=Session("EndDate")%>" REQUIRED>
	</FIELDSET>

	<FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT">Договiр</TD>
	<TD><SELECT NAME="ContractId">
	<% for (; !rs.EOF; rs.MoveNext()) {
		Response.Write('<OPTION VALUE="' + rs.Fields("ContractId") + '">' + rs.Fields("ContractName") + '</OPTION>');
	} rs.Close();Connect.Close()%>
	</SELECT></TD></TR>

	<TR><TD ALIGN="RIGHT">Прийом</TD>
	<TD><INPUT TYPE="Number" NAME="RecVol" STEP="1" MIN="0" MAX="999999" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Видача</TD>
	<TD><INPUT TYPE="Number" NAME="RetVol" STEP="1" MIN="0" MAX="999999" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT" ID="SaldoId">Сальдо</TD>
	<TD><INPUT TYPE="text" NAME="Saldo" READONLY SIZE="7" maxLength="6"></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" DISABLED ONCLICK="return SbmForm()">Створити</BUTTON></FORM></BODY></HTML>