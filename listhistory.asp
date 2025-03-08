<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->

<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Message.Write(2, "Помилка авторизації");

with (Request) {
	var ContractId = Form("ContractId"),
	BegMonth       = String(Form("BegMonth")),
	EndMonth       = String(Form("EndMonth")),
	ContractName   = Form("ContractName");
}

try {
	Solaren.SetCmd("ListHistory");
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
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}

Html.SetHead("Iсторiя розрахункiв");
var ResponseText = '<BODY CLASS="PrnBody">\n' +
'<H3 CLASS="H3PrnTable">Iсторiя розрахункiв</H3><SPAN CLASS="H3PrnTable">' + ContractName + '</SPAN>\n' +
'<TABLE CLASS="PrnTable">\n' +
'<TR><TH>Перiод</TH><TH>Сальдо</TH><TH>Обсяг</TH><TH>Вартiсть</TH><TH>Оплата</TH></TR>\n',
totPurVol = totObDt = totObCt = 0;

for (var i=0; !rs.EOF; i++) {
	ResponseText += '<TR><TD>' + rs.Fields("ReportPeriod") +
	Html.Write("TD","RIGHT") + rs.Fields("s").value.toDelimited(2) + 
	Html.Write("TD","RIGHT") + rs.Fields("PurVol").value.toDelimited(0) + 
	Html.Write("TD","RIGHT") + rs.Fields("ob_dt").value.toDelimited(2) + 
	Html.Write("TD","RIGHT") + rs.Fields("ob_ct").value.toDelimited(2) + '</TD></TR>\n';
	totPurVol += rs.Fields("PurVol");
	totObDt   += rs.Fields("ob_dt");
	totObCt   += rs.Fields("ob_ct");
	rs.MoveNext();
} rs.Close();Solaren.Close();
ResponseText += '<TR><TH ALIGN="LEFT" COLSPAN="2">Всього: ' + i +
Html.Write("TH","RIGHT") + totPurVol.toDelimited(0) +
Html.Write("TH","RIGHT") + totObDt.toDelimited(2) +
Html.Write("TH","RIGHT") + totObCt.toDelimited(2) + '</TH></TR>\n</TABLE></BODY></HTML>';
Response.Write(ResponseText)%>
