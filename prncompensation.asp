<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/money.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
	var ReportMonth = String(Form("ReportMonth")),
	AveragePrice    = String(Form("AveragePrice")).replace(",","."),
	ChiefId         = Form("ChiefId");
}

try {
	Solaren.SetCmd("ListCompensation");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adInteger, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("ReportMonth", adVarChar, adParamInput, 10, ReportMonth));
		}
	}
	var rs = Cmd.Execute();
	Solaren.EOF(rs, 'Iнформацiю не знайдено');
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

Html.SetHead("Компенсація");

var Period = Month.GetPeriod(ReportMonth, 0),
Compensation = totRetVol = totRecVol = totPurVol = totCompensation = 0,
ResponseText = '<BODY CLASS="PrnBody">\n' +
	'<H3 CLASS="H3PrnTable">Компенсація</H3><SPAN CLASS="H3PrnTable">перiод: ' + Period + '</SPAN>\n' +
	'<TABLE CLASS="PrnTable">\n' +
	'<CAPTION>Середньозважена ціна: ' + AveragePrice.replace(".",",") + ' коп.</CAPTION>\n' +
	'<TR><TH ROWSPAN="2">Рахунок</TH><TH COLSPAN="2">Період</TH><TH ROWSPAN="2">Споживач</TH><TH ROWSPAN="2">EIC</TH><TH>Тариф</TH>	<TH COLSPAN="3">кВт&#183;год</TH><TH>Компенсація</TH></TR>\n' +
	'<TR><TH>З</TH><TH>По</TH><TH>коп</TH><TH>Видача</TH><TH>Потреби</TH><TH>Покупка</TH><TH>&#8372;</TH></TR>\n';
for (var i=0; !rs.EOF; i++) {
	Compensation = Math.round(rs.Fields("PurVol") * (rs.Fields("Tarif") - AveragePrice))/100;
	ResponseText += '<TR><TD ALIGN="RIGHT">' + rs.Fields("ContractPAN") +
	Html.Write("TD","") + rs.Fields("BegDate") +
	Html.Write("TD","") + rs.Fields("EndDate") +
	Html.Write("TD","") + rs.Fields("CustomerName") +
	Html.Write("TD","") + rs.Fields("EICode") +
	Html.Write("TD","RIGHT") + rs.Fields("Tarif").value.toDelimited(2) +
	Html.Write("TD","RIGHT") + rs.Fields("RetVol").value.toDelimited(0) +
	Html.Write("TD","RIGHT") + rs.Fields("RecVol").value.toDelimited(0) +
	Html.Write("TD","RIGHT") + rs.Fields("PurVol").value.toDelimited(0) +
	Html.Write("TD","RIGHT") + Compensation.toDelimited(2) + '</TD></TR>\n';
	totRetVol += rs.Fields("RetVol");
	totRecVol += rs.Fields("RecVol");
	totPurVol += rs.Fields("PurVol");
	totCompensation += Compensation;
	rs.MoveNext();
} rs.Close();Connect.Close();
ResponseText += '<TR><TH ALIGN="LEFT" COLSPAN="6">Всього: ' + i +
Html.Write("TH","RIGHT") + totRetVol.toDelimited(0) +
Html.Write("TH","RIGHT") + totRecVol.toDelimited(0) +
Html.Write("TH","RIGHT") + totPurVol.toDelimited(0) +
Html.Write("TH","RIGHT") + totCompensation.toDelimited(2) + '</TH></TR>\n</TABLE></BODY></HTML>';
Response.Write(ResponseText)%>