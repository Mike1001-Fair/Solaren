<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
	var ContractId = Form("ContractId"),
	BegMonth       = String(Form("BegMonth")),
	EndMonth       = String(Form("EndMonth"));
}

try {
	Solaren.SetCmd("ListFactVol");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("ContractId", adVarChar, adParamInput, 10, ContractId));
			Append(CreateParameter("BegMonth", adVarChar, adParamInput, 10, BegMonth));
			Append(CreateParameter("EndMonth", adVarChar, adParamInput, 10, EndMonth));
		}
	}
	var rs = Cmd.Execute();
	Solaren.EOF(rs, 'Iнформацiю не знайдено');

	var Period = Month.GetPeriod(BegMonth, 0),
	nVol = 0, totRetVol = 0, totRecVol = 0, totSaldo = 0, totnVol = 0;
	if (BegMonth != EndMonth) Period += " - " + Month.GetPeriod(EndMonth, 0);

	Html.SetHead("Звiт");
	Response.Write('<BODY CLASS="PrnBody">\n' +
	'<H3 CLASS="H3PrnTable">Баланс</H3><SPAN CLASS="H3PrnTable">перiод: ' + Period + '</SPAN>\n' +
	'<TABLE CLASS="PrnTable">\n' +
	'<TR><TH>Рахунок</TH><TH>З</TH><TH>По</TH><TH>Споживач</TH><TH>Прийом</TH><TH>Видача</TH><TH>Покупка</TH><TH>Потреби</TH></TR>\n');
	for (var i=0; !rs.EOF; i++) {
		nVol = rs.Fields("RetVol") - rs.Fields("PurVol");
		Response.Write('<TR><TD ALIGN="RIGHT">' + rs.Fields("ContractPAN") +
		Html.Write("TD","") + rs.Fields("BegDate") +
		Html.Write("TD","") + rs.Fields("EndDate") +
		Html.Write("TD","")      + rs.Fields("CustomerName") +
		Html.Write("TD","RIGHT") + rs.Fields("RecVol").value.toDelimited(0) +
		Html.Write("TD","RIGHT") + rs.Fields("RetVol").value.toDelimited(0) +
		Html.Write("TD","RIGHT") + rs.Fields("PurVol").value.toDelimited(0) +
		Html.Write("TD","RIGHT") + nVol.toDelimited(0) + '</TD></TR>\n');
		totRecVol += rs.Fields("RecVol");
		totRetVol += rs.Fields("RetVol");
		totSaldo  += rs.Fields("PurVol");
		totnVol   += nVol;
		rs.MoveNext()
	} rs.Close();Connect.Close();
	Response.Write('<TR><TH ALIGN="LEFT" COLSPAN="4">Всього: ' + i +
	Html.Write("TH","RIGHT") + totRecVol.toDelimited(0) +
	Html.Write("TH","RIGHT") + totRetVol.toDelimited(0) +
	Html.Write("TH","RIGHT") + totSaldo.toDelimited(0) +
	Html.Write("TH","RIGHT") + totnVol.toDelimited(0) + '</TH></TR>\n</TABLE></BODY></HTML>');
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}%>