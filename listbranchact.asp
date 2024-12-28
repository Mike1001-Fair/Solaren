<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->

<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
	var BranchId = Form("BranchId"),
	BranchName   = Form("BranchName"),
	BegMonth     = String(Form("BegMonth")),
	EndMonth     = String(Form("EndMonth"));
}

try {
	Solaren.SetCmd("ListBranchAct");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("BegMonth", adVarChar, adParamInput, 10, BegMonth));
			Append(CreateParameter("EndMonth", adVarChar, adParamInput, 10, EndMonth));
			Append(CreateParameter("BranchId", adVarChar, adParamInput, 10, BranchId));
		}
	}
	var rs = Cmd.Execute();
	Solaren.EOF(rs, 'Iнформацiю не знайдено');
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

Html.SetHead("Звiт");

var Period = Month.GetPeriod(BegMonth, 0),
totVol = totVolCost = totPdfo = totVz = totPurCost = 0,
ResponseText = '<BODY CLASS="PrnBody">\n' +
'<H3 CLASS="H3PrnTable">Вартiсть купiвлi електричної енергiї</H3><SPAN CLASS="H3PrnTable">перiод: ' + Period + '</SPAN>\n' +
'<TABLE CLASS="PrnTable">\n' +
'<CAPTION>ЦОС:' + BranchName + '</CAPTION>\n' +
'<TR><TH ROWSPAN="2">З</TH><TH ROWSPAN="2">По</TH><TH ROWSPAN="2">Споживач</TH><TH ROWSPAN="2">Рахунок</TH><TH>Тариф</TH><TH>Обсяг</TH><TH COLSPAN="4">грн</TH></TR>\n' +
'<TR><TH>коп</TH><TH>кВт&#183;год</TH><TH>Вартiсть</TH><TH>ПДФО</TH><TH>ВЗ</TH><TH>До сплати</TH></TR>\n';
if (BegMonth != EndMonth) Period += " - " + Month.GetPeriod(EndMonth, 0);

for (var i=0; !rs.EOF; i++) {
	ResponseText += '<TR><TD>' + rs.Fields("BegDate") +
	Html.Write("TD","") + rs.Fields("EndDate") +
	Html.Write("TD","") + rs.Fields("CustomerName") +
	Html.Write("TD","") + rs.Fields("ContractPAN") +
	Html.Write("TD","RIGHT") + rs.Fields("Tarif").value.toDelimited(2) +
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
} rs.Close();Connect.Close();
ResponseText += '<TR><TH ALIGN="LEFT" COLSPAN="5">Всього: ' + i +
Html.Write("TH","RIGHT") + totVol.toDelimited(0) +
Html.Write("TH","RIGHT") + totVolCost.toDelimited(2) +
Html.Write("TH","RIGHT") + totPdfo.toDelimited(2) +
Html.Write("TH","RIGHT") + totVz.toDelimited(2) +
Html.Write("TH","RIGHT") + totPurCost.toDelimited(2) + '</TH></TR>\n</TABLE></BODY></HTML>';
Response.Write(ResponseText)%>