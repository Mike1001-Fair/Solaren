<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE VIRTUAL="Solaren/Set/list.set" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Message.Write(2, "Помилка авторизації");

with (Request) {
    var OperatorId   = Form("OperatorId"),
	OperatorName = Form("OperatorName"),
	ReportMonth  = String(Form("ReportMonth"));
}

try {
	Db.SetCmd("ListOperatorAct");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("ReportMonth", adVarChar, adParamInput, 10, ReportMonth));
			Append(CreateParameter("OperatorId", adVarChar, adParamInput, 10, OperatorId));
		}
	}
	var rs = Cmd.Execute();
	Db.EOF(rs, 'Iнформацiю не знайдено');
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}

var Period = Month.GetPeriod(ReportMonth, 0),
totRecVol = 0, totRetVol = 0, totSaldo = 0;
Html.SetHead("Звiт");

var Output = '<BODY CLASS="PrnBody">\n' +
'<H3 CLASS="H3PrnTable">Акт звірки</H3><SPAN CLASS="H3PrnTable">перiод: ' + Period + '</SPAN>\n' +
'<TABLE CLASS="PrnTable">\n' +
'<CAPTION>оператор:  ' + OperatorName + '</CAPTION>\n' +
'<TR><TH ROWSPAN="2">EIC</TH><TH ROWSPAN="2">Лічильник</TH><TH COLSPAN="2">Останнi показники</TH><TH COLSPAN="3">кВт&#183;год</TH></TR>\n' +
'<TR><TH>А+</TH><TH>А-</TH><TH>Прийом</TH><TH>Видача</TH><TH>Сальдо</TH></TR>\n';

for (var i=0; !rs.EOF; i++) {
	Output += '<TR><TD>' + rs.Fields("EICode") +
	Html.Write("TD","RIGHT") + rs.Fields("MeterCode") +
	Html.Write("TD","RIGHT") + rs.Fields("RecVal").Value.toDelimited(0) +
	Html.Write("TD","RIGHT") + rs.Fields("RetVal").Value.toDelimited(0) +
	Html.Write("TD","RIGHT") + rs.Fields("RecVol").Value.toDelimited(0) +
	Html.Write("TD","RIGHT") + rs.Fields("RetVol").Value.toDelimited(0) +
	Html.Write("TD","RIGHT") + rs.Fields("Saldo").Value.toDelimited(0) + '</TD></TR>\n';
	totRecVol += rs.Fields("RecVol");
	totRetVol += rs.Fields("RetVol");
	totSaldo += rs.Fields("Saldo");
	rs.MoveNext()
} rs.Close(); Db.Close();

Output += '<TR><TH ALIGN="LEFT" COLSPAN="4">Всього: ' + i +
Html.Write("TH","RIGHT") + totRecVol.toDelimited(0) +
Html.Write("TH","RIGHT") + totRetVol.toDelimited(0) +
Html.Write("TH","RIGHT") + totSaldo.toDelimited(0) + '</TH></TR>\n</TABLE></BODY></HTML>';
Response.Write(Output)%>


