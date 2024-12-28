<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
	BegMonth = String(Form("BegMonth")),
	EndMonth = String(Form("EndMonth"));
}

try {
	Solaren.SetCmd("ListTarifVol");
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

Html.SetHead("Обсяги по тарифам");
var Period = Month.GetPeriod(BegMonth, 0),
totPurVol = totVolCost = 0;

if (BegMonth != EndMonth) Period += " - " + Month.GetPeriod(EndMonth, 0);

var ResponseText = '<BODY CLASS="PrnBody">\n' +
	'<H3 CLASS="H3PrnTable">Обсяги по тарифам</H3><SPAN CLASS="H3PrnTable">перiод: ' + Period + '</SPAN>\n' +
	'<TABLE CLASS="PrnTable">\n' +
	'<TR><TH ROWSPAN="2">Дата вводу<BR>в експлуатацiю</TH><TH ROWSPAN="2">Група</TH><TH>Тариф</TH><TH>Обсяг</TH><TH>Вартiсть</TH></TR>\n' +
	'<TR><TH>коп</TH><TH>кВт&#183;год</TH><TH>грн</TH><TR>\n';
for (var i=0; !rs.EOF; i++) {
	ResponseText += '<TR><TD>' + rs.Fields("ExpPeriod") +
	Html.Write("TD","CENTER") + Html.TarifGroup[rs.Fields("GroupId").value] + 
	Html.Write("TD","RIGHT")  + rs.Fields("Tarif").value.toDelimited(2) + 
	Html.Write("TD","RIGHT")  + rs.Fields("PurVol").value.toDelimited(0) + 
	Html.Write("TD","RIGHT")  + rs.Fields("VolCost").value.toDelimited(2) + '</TD></TR>\n';
	totPurVol += rs.Fields("PurVol");
	totVolCost += rs.Fields("VolCost");
	rs.MoveNext();
} rs.Close();Connect.Close();
ResponseText += '<TR><TH ALIGN="LEFT" COLSPAN="3">Всього: ' + i +
Html.Write("TH","RIGHT") + totPurVol.toDelimited(0) +
Html.Write("TH","RIGHT") + totVolCost.toDelimited(2) + '</TH></TR>\n</TABLE></BODY></HTML>';
Response.Write(ResponseText)%>