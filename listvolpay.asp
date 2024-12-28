<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = Session("RoleId") == 1,
Title = "Звіт";

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
    var BegMonth = String(Form("BegMonth")),
	EndMonth = String(Form("EndMonth"));
}

try {
	Solaren.SetCmd("ListVolPay");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("BegMonth", adVarChar, adParamInput, 10, BegMonth));
			Append(CreateParameter("EndMonth", adVarChar, adParamInput, 10, EndMonth));
		}
	}
	var rs = Cmd.Execute();
	Solaren.EOF(rs, 'Iнформацiю не знайдено');
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

var Period = Month.GetPeriod(BegMonth, 0),
pwr = totRetVol = totPurVol = totPaySum = 0;
if (BegMonth != EndMonth) Period += " - " + Month.GetPeriod(EndMonth, 0);

Html.SetHead(Title);
var ResponseText = '<BODY CLASS="PrnBody">\n' +
	'<H3 CLASS="H3PrnTable">Енергозбереження</H3><SPAN CLASS="H3PrnTable">перiод: ' + Period + '</SPAN>\n' +
	'<TABLE CLASS="PrnTable">\n' +
	'<TR><TH>Споживач</TH><TH>Рахунок</TH><TH>Адреса</TH><TH>Дата</TH><TH>Потужнiсть<BR>кВт</TH><TH>Видача<BR>кВт&#183;год</TH><TH>Покупка<BR>кВт&#183;год</TH><TH>Оплата<BR>&#8372;</TH></TR>\n';

for (var i=0; !rs.EOF; i++) {
	ResponseText += '<TR><TD>' + rs.Fields("CustomerName") +
	Html.Write("TD","") + rs.Fields("ContractPAN") +
	Html.Write("TD","") + rs.Fields("CustomerAddress") +
	Html.Write("TD","") + rs.Fields("ContractDate") +
	Html.Write("TD","RIGHT") + rs.Fields("ContractPower").value.toDelimited(2) +
	Html.Write("TD","RIGHT") + rs.Fields("RetVol").value.toDelimited(0) +
	Html.Write("TD","RIGHT") + rs.Fields("PurVol").value.toDelimited(0) +
	Html.Write("TD","RIGHT") + rs.Fields("PaySum").value.toDelimited(2) + '</TD></TR>\n';
	pwr += rs.Fields("ContractPower");
	totRetVol  += rs.Fields("RetVol");
	totPurVol  += rs.Fields("PurVol");
	totPaySum  += rs.Fields("PaySum");
	rs.MoveNext();
} rs.Close();Connect.Close();

ResponseText += '<TR><TH ALIGN="LEFT" COLSPAN="4">Всього: ' + i +
	Html.Write("TH","RIGHT") + pwr.toDelimited(2) +
	Html.Write("TH","RIGHT") + totRetVol.toDelimited(0) +
	Html.Write("TH","RIGHT") + totPurVol.toDelimited(0) +
	Html.Write("TH","RIGHT") + totPaySum.toDelimited(2) + '</TH></TR>\n</TABLE></BODY></HTML>';
Response.Write(ResponseText)%>