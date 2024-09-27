<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
	var FactVolId = QueryString("FactVolId");
}

try {
	Solaren.SetCmd("SelectContract");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 3, Session("UserId")));
			Append(CreateParameter("Deleted", adBoolean, adParamInput, 1, 1));
		}
	}
	var rs = Cmd.Execute();
	Solaren.EOF(rs, 'Довідник договорів пустий!');

	with (Cmd) {
		CommandText = "GetOper";
		with (Parameters) {
			while (Count > 0) { Delete(0) };
			Append(CreateParameter("FactVolId", adInteger, adParamInput, 10, FactVolId));
		}
	}
	var rsVol = Cmd.Execute();

	with (rsVol) {
		var ContractId = Fields("ContractId").value,
		BegDate        = Fields("BegDate").value,
		EndDate        = Fields("EndDate").value,
		RetVol         = Fields("RetVol").value,
		VolCost        = Fields("VolCost").value,
		Deleted        = Fields("Deleted").value;
		Close();
	}

	with (Html) {
		SetHead("Редагування операції");
		WriteMenu(Session("RoleId"), 0);
	}
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}%>
<SCRIPT>
function LoadForm() {
	with (EditOper) {
		let BegDate = new Date("<%=BegDate%>"),
		OperDate = new Date("<%=Session("OperDate")%>"),
		elm = document.getElementById("H3Id");

		if (Deleted.value == "True") {
			elm.textContent = "Перегляд операції";
			OperSet.disabled = true;
		} else if (BegDate < OperDate) {
			elm.textContent = "Перегляд операції";
			OperSet.disabled = true;
			SbmBtn.disabled = true;
			DelBtn.disabled = true;
		}		
	}
}

function ChkForm() {
	with (EditOper) {
		if (Deleted.value != "True") {
			EndDate.min = BegDate.value;
			SbmBtn.disabled = !BegDate.validity.valid || !EndDate.validity.valid || !VolCost.validity.valid || !RetVol.validity.valid;
		}
	}

}

function DelOper() {
	if (confirm("Ви впевненнi ?")) {
		EditOper.action = "delfactvol.asp?FactVolId=<%=FactVolId%>&Deleted=<%=Deleted%>"
	} else return false

}
</SCRIPT>

<BODY CLASS="MainBody" ONLOAD="LoadForm()">
<FORM CLASS="ValidForm" NAME="EditOper" ACTION="updateoper.asp" METHOD="POST" ONINPUT="ChkForm()">
<INPUT TYPE="HIDDEN" NAME="FactVolId" VALUE="<%=FactVolId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">

<H3 CLASS="HeadText" ID="H3Id"><%=Deleted ? "Перегляд" : "Редагування"%> операції</H3>
<TABLE CLASS="MarkupTable">
       	<TR><TD>
	<FIELDSET NAME="OperSet"><LEGEND ALIGN="CENTER">Параметри</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT">Перioд</TD>
	<TD><INPUT TYPE="date" NAME="BegDate" VALUE="<%=BegDate%>" MIN="<%=Html.MinDate%>" MAX="<%=Html.MaxDate%>" REQUIRED> &#8722;
	<INPUT TYPE="date" NAME="EndDate" VALUE="<%=EndDate%>" MIN="<%=Html.MinDate%>" MAX="<%=Html.MaxDate%>" REQUIRED>

	<TR><TD ALIGN="RIGHT">Договiр</TD>
	<TD><SELECT NAME="ContractId">
	<% for (var selected; !rs.EOF; rs.MoveNext()) {
		selected = rs.Fields("ContractId") == ContractId ? '" SELECTED>' : '">';
		Response.Write('<OPTION VALUE="' + rs.Fields("ContractId") + selected + rs.Fields("ContractName") + '</OPTION>');
	} rs.Close(); Connect.Close()%>
	</SELECT></TD></TR>

	<TR><TD ALIGN="RIGHT">Видача</TD>
	<TD><INPUT TYPE="Number" NAME="RetVol" VALUE="<%=RetVol%>" STEP="1" MIN="0" MAX="999999" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">Вартість</TD>
	<TD><INPUT TYPE="Number" NAME="VolCost" VALUE="<%=VolCost%>" STEP="0.01" MIN="0" MAX="99999999" REQUIRED></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<% if (Deleted) {%><BUTTON CLASS="RestoreBtn" NAME="DelBtn" onclick="return DelOper()">&#9851;Вiдновити</BUTTON>
<%} else {%><BUTTON CLASS="SbmBtn" NAME="SbmBtn" ONCLICK="return SbmForm()">&#128190;Зберегти</BUTTON>
<BUTTON CLASS="DelBtn" NAME="DelBtn" onclick="return DelOper()">&#128465;Видалити</BUTTON><%}%></FORM></BODY></HTML>
