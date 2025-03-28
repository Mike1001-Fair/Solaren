<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = Session("RoleId") > 0 && Session("RoleId") < 3,
Title = "Звіт";

if (!Authorized) Message.Write(2, "Помилка авторизації");

with (Request) {
	var ContractId = Form("ContractId"),
	BegMonth       = String(Form("BegMonth")),
	EndMonth       = String(Form("EndMonth"));
}

try {
	Solaren.SetCmd("ListTotVolCost");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("BegMonth", adVarChar, adParamInput, 10, BegMonth));
			Append(CreateParameter("EndMonth", adVarChar, adParamInput, 10, EndMonth));
			Append(CreateParameter("ContractId", adVarChar, adParamInput, 10, ContractId));
		}
	}
	var rs = Cmd.Execute();
	Solaren.EOF(rs, 'Iнформацiю не знайдено');
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}

var Period = Month.GetPeriod(BegMonth, 0),
totVol = totVolCost = totPdfo = totVz = totPurCost = 0;

if (BegMonth != EndMonth) Period += " - " + Month.GetPeriod(EndMonth, 0);

Html.SetHead(Title);
var ResponseText = '<BODY CLASS="PrnBody">\n' +
	'<H3 CLASS="H3PrnTable">Вартiсть купiвлi електричної енергiї<SPAN>перiод: ' + Period + '</SPAN></H3>\n' +
	'<TABLE CLASS="PrnTable">\n' +
	'<TR><TH ROWSPAN="2">Рахунок</TH><TH ROWSPAN="2">Споживач</TH><TH>Обсяг</TH><TH COLSPAN="4">&#8372;</TH></TR>\n' +
	'<TR><TH>кВт&#183;год</TH><TH>Вартiсть</TH><TH>ПДФО</TH><TH>ВЗ</TH><TH>До сплати</TH></TR>\n';

for (var i=0; !rs.EOF; i++) {
	ResponseText += '<TR><TD ALIGN="RIGHT">' + rs.Fields("ContractPAN") +
	Html.Write("TD","") + rs.Fields("CustomerName") +
	Html.Write("TD","RIGHT") + rs.Fields("Vol").value.toDelimited(0) +
	Html.Write("TD","RIGHT") + rs.Fields("VolCost").value.toDelimited(2) +
	Html.Write("TD","RIGHT") + rs.Fields("Pdfo").value.toDelimited(2) +
	Html.Write("TD","RIGHT") + rs.Fields("Vz").value.toDelimited(2) +
	Html.Write("TD","RIGHT") + rs.Fields("PurCost").value.toDelimited(2) + '</TD></TR>\n';
	totVol     += rs.Fields("Vol");
	totVolCost += rs.Fields("VolCost");
	totPdfo    += rs.Fields("Pdfo");
	totVz      += rs.Fields("Vz");
	totPurCost += rs.Fields("PurCost");
	rs.MoveNext();
} rs.Close();Solaren.Close();

ResponseText += '<TR><TH ALIGN="LEFT" COLSPAN="2">Всього: ' + i +
	Html.Write("TH","RIGHT") + totVol.toDelimited(0) +
	Html.Write("TH","RIGHT") + totVolCost.toDelimited(2) +
	Html.Write("TH","RIGHT") + totPdfo.toDelimited(2) +
	Html.Write("TH","RIGHT") + totVz.toDelimited(2) +
	Html.Write("TH","RIGHT") + totPurCost.toDelimited(2) + '</TH></TR>\n</TABLE></BODY></HTML>';
Response.Write(ResponseText)%>
