<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

try {
	Solaren.SetCmd("SelectOperator");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
		}
	}
	var rs = Cmd.Execute();
	Solaren.EOF(rs, 'Довiдник операторiв пустий');
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

with (Html) {
	SetHead("Акт звірки ОСР");
	Menu.Write(Session("RoleId"), 0);
}%>
<SCRIPT>
function ChkForm() {
	with(FindOperatorAct) {
		SbmBtn.disabled = !ReportMonth.validity.valid;
	}
}

function SetOperatorName() {
	with (FindOperatorAct) {
		let selectedOption = OperatorId.options[OperatorId.selectedIndex];
		OperatorName.value = selectedOption.text;
	}
}
</SCRIPT>


<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindOperatorAct" ACTION="listoperatoract.asp" METHOD="post" TARGET="_blank" ONINPUT="ChkForm()">
<INPUT TYPE="HIDDEN" NAME="OperatorName">
<H3 CLASS="HeadText">Акт звірки ОСР</H3>
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET><LEGEND ALIGN="CENTER">Параметри</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT">Період</TD>
	<TD><INPUT TYPE="Month" NAME="ReportMonth" VALUE="<%=Month.GetMonth(1)%>" MIN="<%=Month.GetMonth(1)%>" MAX="<%=Month.GetMonth(1)%>"  REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Оператор</TD>
	<TD><SELECT NAME="OperatorId">
	<% for (; !rs.EOF; rs.MoveNext()) {
		Response.Write('<OPTION VALUE="' + rs.Fields("OperatorId") + '">' + rs.Fields("OperatorName") + '</OPTION>');
	} rs.Close();Connect.Close()%>
	</SELECT></TD></TR>
	</TABLE></FIELDSET>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ONCLICK="SetOperatorName()">&#128270;Пошук</BUTTON></FORM></BODY></HTML>