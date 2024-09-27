<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = Session("RoleId") == 1,
FactVolId = Request.QueryString("FactVolId");
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

try {
	Solaren.SetCmd("SelectContract");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("Deleted", adBoolean, adParamInput, 1, 1));
		}
	}
	var rs = Cmd.Execute();
	Solaren.EOF(rs, 'Довідник договорів пустий!');

	with (Cmd) {
		CommandText = "GetFactVol";
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
		RecVol         = Fields("RecVol").value,
		RetVol         = Fields("RetVol").value,
		IndicatorId    = Fields("IndicatorId").value,
		Deleted        = Fields("Deleted").value;
		Close();
	}

} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

var ViewOnly = !Month.isPeriod(Session("OperDate"), EndDate),
Title = Deleted || ViewOnly || IndicatorId != "" ? "Перегляд операції" : "Редагування операції";

with (Html) {
	SetHead(Title);
	WriteMenu(Session("RoleId"), 0);
}%>
<SCRIPT>
function LoadForm() {
	let BegDate  = new Date(EditFactVol.BegDate.value),
	OperDate = new Date("<%=Session("OperDate")%>");

	with (EditFactVol) {
		if (Deleted.value == "True") {
			let Elements = document.querySelectorAll("fieldset");
			Elements.forEach(elm => elm.disabled = true);
		} else if (BegDate < OperDate || IndicatorId.value != "") {
			let Elements = document.querySelectorAll("fieldset, button");
			Elements.forEach(elm => elm.disabled = true);
		}
	}
}

function ChkForm() {
	with (EditFactVol) {
		let elm    = document.getElementById("SaldoId"),
		retvol     = parseInt(EditFactVol.RetVol.value, 10),
		recvol     = parseInt(EditFactVol.RecVol.value, 10),
		saldo      = recvol - retvol,
		notsaldo   = isNaN(saldo) || (retvol==0 && recvol==0);
		Saldo.value = isNaN(saldo) ? "" : Math.abs(saldo);
		elm.textContent = (notsaldo || !saldo) ? "Сальдо" : saldo > 0 ? "Продаж" : "Покупка";
		if (Deleted.value != "True") {
			SbmBtn.disabled = !BegDate.validity.valid || !EndDate.validity.valid || !RecVol.validity.valid || !RetVol.validity.valid || notsaldo;
		}
	}
}

function DelFactVol() {
	if (confirm("Ви впевненнi ?")) {
		EditFactVol.action = "delfactvol.asp?FactVolId=<%=FactVolId%>&Deleted=<%=Deleted%>"
	} else return false

}

function SbmForm() {
	let Confirmed = confirm("Ви впевненi\u2753");
	return Confirmed
}
</SCRIPT>

<BODY CLASS="MainBody" ONLOAD="ChkForm();LoadForm()">
<FORM CLASS="ValidForm" NAME="EditFactVol" ACTION="updatefactvol.asp" METHOD="POST" ONINPUT="ChkForm()">
<INPUT TYPE="HIDDEN" NAME="FactVolId" VALUE="<%=FactVolId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">
<INPUT TYPE="HIDDEN" NAME="IndicatorId" VALUE="<%=IndicatorId%>">

<H3 CLASS="HeadText" ID="H3Id"><%=Title%></H3>
<TABLE CLASS="MarkupTable">
       	<TR><TD>
	<FIELDSET NAME="VolSet"><LEGEND ALIGN="CENTER">Параметри</LEGEND>
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

	<TR><TD ALIGN="RIGHT">Прийом</TD>
	<TD><INPUT TYPE="Number" NAME="RecVol" VALUE="<%=RecVol%>" STEP="1" MIN="0" MAX="999999" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Видача</TD>
	<TD><INPUT TYPE="Number" NAME="RetVol" VALUE="<%=RetVol%>" STEP="1" MIN="0" MAX="999999" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT" ID="SaldoId">Сальдо</TD>
	<TD><INPUT TYPE="text" NAME="Saldo" SIZE="7" maxLength="6" READONLY></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<% Html.WriteEditButton(1)%>
</FORM></BODY></HTML>
