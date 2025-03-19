<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Message.Write(2, "Помилка авторизації");

with (Request) {
    var OperatorId   = Form("OperatorId"),
	OperatorName = Form("OperatorName"),
	BegMonth     = String(Form("BegMonth")),
	EndMonth     = String(Form("EndMonth"));
}

try {
	Solaren.SetCmd("ListBalance");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("BegMonth", adVarChar, adParamInput, 10, BegMonth));
			Append(CreateParameter("EndMonth", adVarChar, adParamInput, 10, EndMonth));
			Append(CreateParameter("OperatorId", adVarChar, adParamInput, 10, OperatorId));
		}
	}
	var rs = Solaren.Execute("ListBalance");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}

var Period = Month.GetPeriod(BegMonth, 0),
totRetVol = totPurVol = totNeedVol = 0;
if (BegMonth != EndMonth) Period += " - " + Month.GetPeriod(EndMonth, 0);

Html.SetHead("Баланс");

var ResponseText = '<BODY CLASS="PrnBody">\n' +
	'<H3 CLASS="H3PrnTable">Баланс</H3><SPAN CLASS="H3PrnTable">перiод: ' + Period + '</SPAN>\n' +
	'<TABLE CLASS="PrnTable">\n' +
	'<CAPTION>оператор:' + OperatorName + '</CAPTION>\n' +
	'<TR><TH>РЕМ</TH><TH>Видача</TH><TH>Покупка</TH><TH>Потреби</TH></TR>\n';

for (var i=0; !rs.EOF; i++) {
	ResponseText += '<TR><TD>' + rs.Fields("AenName") +
	Html.Write("TD","RIGHT") + rs.Fields("RetVol").value.toDelimited(0) +
	Html.Write("TD","RIGHT") + rs.Fields("PurVol").value.toDelimited(0) +
	Html.Write("TD","RIGHT") + rs.Fields("NeedVol").value.toDelimited(0) + '</TD></TR>\n';
	totRetVol += rs.Fields("RetVol");
	totPurVol += rs.Fields("PurVol");
	totNeedVol += rs.Fields("NeedVol");
	rs.MoveNext();
}
rs.Close();
Solaren.Close();

ResponseText += '<TR><TH ALIGN="LEFT">Всього: ' + i +
	Html.Write("TH","RIGHT") + totRetVol.toDelimited(0) +
	Html.Write("TH","RIGHT") + totPurVol.toDelimited(0) +
	Html.Write("TH","RIGHT") + totNeedVol.toDelimited(0) + 
	'</TH></TR>\n</TABLE></BODY></HTML>';
Response.Write(ResponseText)%>
