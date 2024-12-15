<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<!-- #INCLUDE FILE="Include/dataset.inc" -->
<% var Authorized = Session("RoleId") == 2;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
    var UserId       = Session("UserId"),
	ReportMonth  = String(Form("ReportMonth")),
	ContractId   = Form("ContractId"),
	DoubleReport = Form("DoubleReport") == "on";
}

try {
	Solaren.SetCmd("GetIndicatorReport");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, UserId));
			Append(CreateParameter("ReportMonth", adVarChar, adParamInput, 10, ReportMonth));
			Append(CreateParameter("ContractId", adInteger, adParamInput, 10, ContractId));
		}
	}

	DataSet.Open(Cmd);
	Solaren.EOF(RecordSet, 'Iнформацiю не знайдено');

	with (Cmd) {
		CommandText = "GetReportInfo";
		with (Parameters) {
			Delete("ReportMonth");
			Append(CreateParameter("CustomerName", adVarChar, adParamOutput, 50, "")),
			Append(CreateParameter("ContractLocalityType", adTinyInt, adParamOutput, 10, 0));
			Append(CreateParameter("ContractLocalityName", adVarChar, adParamOutput, 30, ""));
			Append(CreateParameter("ContractStreetType", adTinyInt, adParamOutput, 10, 0));
			Append(CreateParameter("ContractStreetName", adVarChar, adParamOutput, 30, ""));
			Append(CreateParameter("HouseId", adVarChar, adParamOutput, 20, ""));
			Append(CreateParameter("ContractDate", adVarChar, adParamOutput, 10, "")),
			Append(CreateParameter("ContractPAN", adVarChar, adParamOutput, 10, "")),
			Append(CreateParameter("BranchName", adVarChar, adParamOutput, 30, "")),
			Append(CreateParameter("ChiefTitle", adVarChar, adParamOutput, 30, "")),
			Append(CreateParameter("ChiefName", adVarChar, adParamOutput, 50, ""));
			Append(CreateParameter("BranchLocalityType", adTinyInt, adParamOutput, 10, 0));
			Append(CreateParameter("BranchLocalityName", adVarChar, adParamOutput, 30, ""));
		} Execute(adExecuteNoRecords);

		with (Parameters) {
			var CustomerName     = Item("CustomerName").value,
			ContractLocalityType = Item("ContractLocalityType").value,
			ContractLocalityName = Item("ContractLocalityName").value,
			ContractStreetType   = Item("ContractStreetType").value,
			ContractStreetName   = Item("ContractStreetName").value,
			HouseId              = Item("HouseId").value,
			ContractDate         = Item("ContractDate").value,
			ContractPAN          = Item("ContractPAN").value,
			BranchName           = Item("BranchName").value,
			ChiefTitle           = Item("ChiefTitle").value,
			ChiefName            = Item("ChiefName").value,
			BranchLocalityType   = Item("BranchLocalityType").value,
			BranchLocalityName   = Item("BranchLocalityName").value;
		}
	}
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex));
}

var Period      = Month.GetPeriod(ReportMonth, 1),
EndDate         = Month.GetLastDay(ReportMonth),
LocalityType    = Html.LocalityType[ContractLocalityType],
StreetType      = Html.StreetType[ContractStreetType],
ContractAddress = [LocalityType, ContractLocalityName + ", ", StreetType, ContractStreetName, HouseId].join(" "),
BranchLocality  = [Html.LocalityType[BranchLocalityType],  BranchLocalityName].join(" "),
ResponseText    = '<BODY CLASS="ActContainer">\n';

Html.SetHead("Звіт про показники");

for (var i=0; i<=DoubleReport; i++) {
	var totSaldo = 0;
	ResponseText += '<DIV CLASS="ActText">\n<TABLE CLASS="NoBorderTable">\n' +
	'<TR><TD></TD><TD CLASS="ReportTitle">Додаток до договору купiвлi-продажу електричної енергiї за "зеленим" тарифом приватним домогосподарством вiд 01.01.2019 р.</TD></TR>\n' +
	'</TABLE>\n' +
	'<H3 CLASS="H3PrnTable">Звiт</H3><SPAN>про показники лiчильника, обсяги та напрямки перетокiв електричної енергiї в ' + Period + '</SPAN>\n' +
	'<TABLE CLASS="ActTable">\n' +
	'<CAPTION>Споживач: ' + CustomerName + '<BR>Рахунок: ' + ContractPAN + '<BR>Адреса: ' + ContractAddress + '</CAPTION>\n' +
	'<TR ALIGN="CENTER"><TD ROWSPAN="2">№<BR>лiчильника</TD><TD ROWSPAN="2">Вид<BR>вимiрювання</TD><TD COLSPAN="2">Показники</TD>' +
	'<TD ROWSPAN="2">Рiзниця</TD><TD ROWSPAN="2">Коефiцiєнт<BR>трансформацiї</TD><TD>Всього</TD></TR>\n' +
	'<TR ALIGN="CENTER"><TD>останнi</TD><TD>попереднi</TD><TD>кВт&#183;год</TD></TR>';
				
	for (; !RecordSet.EOF; RecordSet.MoveNext()) {
		var k = RecordSet.Fields("kTransForm"),
		c = RecordSet.Fields("Capacity"),
		PrevDate = Solaren.GetYMD(RecordSet.Fields("PrevDate")),
		ReportDate = Solaren.GetYMD(RecordSet.Fields("ReportDate")),
		recsaldo = RecordSet.Fields("RecVal") - RecordSet.Fields("PrevRecVal"),
		retsaldo = RecordSet.Fields("RetVal") - RecordSet.Fields("PrevRetVal"),
		periodSaldo;

		if (recsaldo < 0) recsaldo += Math.pow(10, c);
		if (retsaldo < 0) retsaldo += Math.pow(10, c);

		periodSaldo = (recsaldo - retsaldo) * k;
		totSaldo += periodSaldo;

		ResponseText += '<TR><TD ALIGN="CENTER">' + RecordSet.Fields("MeterCode") +
		Html.Write("TD","CENTER") + 'Прийом А+' +
		Html.Write("TD","RIGHT") + RecordSet.Fields("RecVal") +
		Html.Write("TD","RIGHT") + RecordSet.Fields("PrevRecVal") +
		Html.Write("TD","RIGHT") + recsaldo +
		Html.Write("TD","CENTER") + k +
		Html.Write("TD","RIGHT") + recsaldo*k + '</TD></TR><TR><TD ALIGN="CENTER">' + RecordSet.Fields("MeterCode") +
		Html.Write("TD","CENTER") + 'Видача А-' +
		Html.Write("TD","RIGHT") + RecordSet.Fields("RetVal") +
		Html.Write("TD","RIGHT") + RecordSet.Fields("PrevRetVal") +
		Html.Write("TD","RIGHT") + retsaldo +
		Html.Write("TD","CENTER") + k +
		Html.Write("TD","RIGHT") + retsaldo*k + '</TD></TR>' +
		'<TR><TD ALIGN="LEFT" COLSPAN="6">Сальдо з ' + PrevDate.formatDate("-") + ' по ' + ReportDate.formatDate("-") + '</TD>' +
		'<TD ALIGN="RIGHT">' + periodSaldo + '</TD></TR>\n';
	}
	if (totSaldo != 0) {
		var resultText = "За результатами знятих показникiв: ",
		s = " електроенергiю, згiдно умов договору ";
		if (totSaldo < 0) {
			totSaldo = -totSaldo;
			resultText += "Постачальник оплачує Споживачу" + s + "купiвлі-продажу електричної енергiї"
		} else resultText += "Споживач оплачує Постачальнику" + s + "про постачання електричної енергiї";
		resultText += ", в обсязi " + totSaldo.toDelimited(0) + " кВт&#183;год."
	}
	ResponseText += '</TABLE>\n<P>'+ resultText + '</P><TABLE CLASS="NoBorderTable">\n' + 
	'<TR ALIGN="CENTER"><TD WIDTH="50%">Постачальник:</TD><TD WIDTH="50%">Споживач:</TD></TR>\n' +
	'<TR ALIGN="CENTER"><TD STYLE="padding: 10px 0px 0px">' + BranchName + ' ЦОС</TD><TD STYLE="padding: 10px 0px 0px">' + CustomerName + '</TD></TR>\n' +
	'<TR ALIGN="CENTER"><TD>' + ChiefTitle + ' ' + ChiefName + '</TD><TD></TD></TR>\n' +
	'<TR ALIGN="CENTER"><TD><DIV CLASS="UnderLine"></DIV></TD>\n' +
	'<TD><DIV CLASS="UnderLine"></DIV></TD></TR>\n</TABLE>\n' +
	'<DIV CLASS="EventInfo">' + BranchLocality + ', ' + EndDate + '</DIV></DIV>\n';

	if (i==0 && DoubleReport) ResponseText += '<DIV CLASS="BlockDivider"></DIV>\n';
	RecordSet.MoveFirst();
}
RecordSet.Close();
Connect.Close();
ResponseText += '</BODY></HTML>';
Response.Write(ResponseText)%>