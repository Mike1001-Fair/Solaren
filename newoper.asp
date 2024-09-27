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
		SetHead("Нова операція");
		WriteMenu(Session("RoleId"), 0);
	}
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex));
}%>
<SCRIPT>
function ChkForm() {
	with (NewOper) {
		EndDate.min = BegDate.value;
		SbmBtn.disabled = !BegDate.validity.valid || !EndDate.validity.valid || !VolCost.validity.valid || !RetVol.validity.valid;
	}
}

function SbmForm() {
	let Confirmed = confirm("Ви впевненi\u2753");
	return Confirmed;
}
</SCRIPT>

<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewOper" ACTION="createoper.asp" METHOD="post" ONINPUT="ChkForm()">
<H3 CLASS="HeadText">Нова операція</H3>
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

	<TR><TD ALIGN="RIGHT">Видача</TD>
	<TD><INPUT TYPE="Number" NAME="RetVol" STEP="1" MIN="0" MAX="999999" PLACEHOLDER="кВт&#183;год" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Вартість</TD>
	<TD><INPUT TYPE="Number" NAME="VolCost" STEP="0.01" MIN="0" MAX="99999999" PLACEHOLDER="&#8372;" REQUIRED></TD></TR>
	</TABLE></FIELDSET>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" DISABLED ONCLICK="return SbmForm()">Створити</BUTTON></FORM></BODY></HTML>
