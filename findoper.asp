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
		SetHead("Пошук операцій");
		WriteMenu(Session("RoleId"), 0);
	}
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex));
}%>
<SCRIPT>
function ChkForm() {
	with (FindOper) {
		BegMonth.max = EndMonth.value;
		SbmBtn.disabled = !BegMonth.validity.valid || !EndMonth.validity.valid;
	}
}

function SetContractName() {
	with (FindOper) {	
		let selectedOption = ContractId.options[ContractId.selectedIndex];
		ContractName.value = selectedOption.text
	}
}
</SCRIPT>

<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindOper" ACTION="listoper.asp" METHOD="post" ONINPUT="ChkForm()">
<INPUT TYPE="HIDDEN" NAME="ContractName">
<H3 CLASS="HeadText">Обсяги</H3>

<TABLE CLASS="MarkupTable">
       	<TR><TD ALIGN="CENTER">
	<FIELDSET><LEGEND>Перioд</LEGEND>
	<INPUT TYPE="Month" NAME="BegMonth" VALUE="<%=Session("OperMonth")%>" MIN="2015-01" MAX="9999-12" REQUIRED> &#8722;
	<INPUT TYPE="Month" NAME="EndMonth" VALUE="<%=Session("OperMonth")%>" MIN="2015-01" MAX="9999-12" REQUIRED>
	</FIELDSET>

	<FIELDSET><LEGEND>Договiр</LEGEND>
	<SELECT NAME="ContractId">
	<% for (; !rs.EOF; rs.MoveNext()) {
		Response.Write('<OPTION VALUE="' + rs.Fields("ContractId") + '">' + rs.Fields("ContractName") + '</OPTION>');
	} rs.Close();Connect.Close()%>
	</SELECT>
	</FIELDSET>
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ONCLICK="SetContractName()">&#128270;Пошук</BUTTON></FORM></BODY></HTML>