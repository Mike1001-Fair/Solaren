<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/locality.inc" -->
<!-- #INCLUDE FILE="Include/street.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = User.RoleId == 2;
User.ValidateAccess(Authorized, "POST");

function getText(totSaldo) {
	if (totSaldo != 0) {
		var resultText = ["За результатами знятих показникiв: "],
		s = " електроенергiю, згiдно умов договору ";
		if (totSaldo < 0) {
			totSaldo = -totSaldo;
			resultText.push("Постачальник оплачує Споживачу" + s + "купiвлі-продажу електричної енергiї")
		} else {
			resultText.push("Споживач оплачує Постачальнику" + s + "про постачання електричної енергiї");
		}
		resultText.push(", в обсязi " + totSaldo.toDelimited(0) + " кВт&#183;год.")
	}
	return resultText.join("")
}

with (Request) {
    var ReportMonth  = String(Form("ReportMonth")),
	ContractId   = Form("ContractId"),
	DoubleReport = Form("DoubleReport") == "on";
}

try {
	Solaren.SetCmd("GetReportInfo");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("ContractId", adInteger, adParamInput, 10, ContractId));
		}
	}
	var rsInfo = Solaren.Execute("GetReportInfo", "Iнформацiю не знайдено");

	Cmd.Parameters.Append(Cmd.CreateParameter("ReportMonth", adVarChar, adParamInput, 10, ReportMonth));
	var rs = Solaren.Execute("GetIndicatorReport", "Iнформацiю не знайдено");
	
	with (rsInfo) {
		var CustomerName     = Fields("CustomerName").value,
		ContractLocalityType = Fields("ContractLocalityType").value,
		ContractLocalityName = Fields("ContractLocalityName").value,
		ContractStreetType   = Fields("ContractStreetType").value,
		ContractStreetName   = Fields("ContractStreetName").value,
		HouseId              = Fields("HouseId").value,
		ContractDate         = Solaren.GetYMD(Fields("ContractDate").value),
		ContractPAN          = Fields("ContractPAN").value,
		BranchName           = Fields("BranchName").value,
		ChiefTitle           = Fields("ChiefTitle").value,
		ChiefName            = Fields("ChiefName").value,
		BranchLocalityType   = Fields("BranchLocalityType").value,
		BranchLocalityName   = Fields("BranchLocalityName").value;
		Close();
	}
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex));
}

var Period      = Month.GetPeriod(ReportMonth, 1),
EndDate         = Month.GetLastDay(ReportMonth),
LocalityType    = Locality.Type[ContractLocalityType],
StreetType      = Street.Type[ContractStreetType],
ContractAddress = [LocalityType, ContractLocalityName + ", ", StreetType, ContractStreetName, HouseId].join(" "),
BranchLocality  = [Locality.Type[BranchLocalityType],  BranchLocalityName].join(" "),
DocRef          = ['Додаток до договору купiвлi-продажу електричної енергiї за "зеленим" тарифом приватним домогосподарством вiд ', ContractDate.formatDate("-"), ' р.'],
Body            = [],
Divider         = DoubleReport ? '<DIV CLASS="BlockDivider"></DIV>\n' : '',
ResponseText    = ['<BODY CLASS="ActContainer">\n'];

Html.SetHead("Звіт про показники");

for (var i=0; i<=DoubleReport; i++) {
	if (i==0) {
		var totSaldo = 0,		
		block = ['<DIV CLASS="ActText">\n<TABLE CLASS="NoBorderTable">\n',
			'<TR><TD></TD><TD CLASS="ReportTitle">', DocRef.join(""), '</TD></TR>\n',
			'</TABLE>\n',
			'<H3 CLASS="H3PrnTable">Звiт</H3><SPAN>про показники лiчильника, обсяги та напрямки перетокiв електричної енергiї в ' + Period + '</SPAN>\n',
			'<TABLE CLASS="ActTable">\n',
			'<CAPTION>Споживач: ' + CustomerName + '<BR>Рахунок: ' + ContractPAN + '<BR>Адреса: ' + ContractAddress + '</CAPTION>\n',
			'<TR><TD ROWSPAN="2">№<BR>лiчильника</TD><TD ROWSPAN="2">Вид<BR>вимiрювання</TD><TD COLSPAN="2">Показники</TD>',
			'<TD ROWSPAN="2">Рiзниця</TD><TD ROWSPAN="2">Коефiцiєнт<BR>трансформацiї</TD><TD>Всього</TD></TR>\n',
			'<TR><TD>останнi</TD><TD>попереднi</TD><TD>кВт&#183;год</TD></TR>'
		];
				
		for (var row; !rs.EOF; rs.MoveNext()) {
			var k = rs.Fields("kTransForm"),
			c = rs.Fields("Capacity"),
			PrevDate = Solaren.GetYMD(rs.Fields("PrevDate")),
			ReportDate = Solaren.GetYMD(rs.Fields("ReportDate")),
			recsaldo = rs.Fields("RecVal") - rs.Fields("PrevRecVal"),
			retsaldo = rs.Fields("RetVal") - rs.Fields("PrevRetVal"),
			periodSaldo;

			if (recsaldo < 0) recsaldo += Math.pow(10, c);
			if (retsaldo < 0) retsaldo += Math.pow(10, c);

			periodSaldo = (recsaldo - retsaldo) * k;
			totSaldo += periodSaldo;

			row = ['<TR>', Tag.Write("TD", 1, rs.Fields("MeterCode")),
				Tag.Write("TD", 1, "Прийом А+"),
				Tag.Write("TD", 2, rs.Fields("RecVal")),
				Tag.Write("TD", 2, rs.Fields("PrevRecVal")),
				Tag.Write("TD", 2, recsaldo),
				Tag.Write("TD", 1, k),
				Tag.Write("TD", 2, recsaldo * k), '</TR>',
				'<TR>', Tag.Write("TD", 1, rs.Fields("MeterCode")),
				Tag.Write("TD", 1, "Видача А-"),
				Tag.Write("TD", 2, rs.Fields("RetVal")),
				Tag.Write("TD", 2, rs.Fields("PrevRetVal")),
				Tag.Write("TD", 2, retsaldo),
				Tag.Write("TD", 1,  k),
				Tag.Write("TD", 2,  retsaldo * k), '</TR>',
				'<TR><TD ALIGN="LEFT" COLSPAN="6">Сальдо з ' + PrevDate.formatDate("-") + ' по ' + ReportDate.formatDate("-") + '</TD>',
				Tag.Write("TD", 2, periodSaldo), '</TR>\n'
			];
			block.push(row.join(""));
		}

		var footer = ['</TABLE>\n<P>'+ getText(totSaldo) + '</P>',
			'<TABLE CLASS="NoBorderTable">\n',
			'<TR><TD WIDTH="50%">Постачальник:</TD><TD WIDTH="50%">Споживач:</TD></TR>\n',
			'<TR><TD STYLE="padding: 10px 0px 0px">' + BranchName + ' ЦОС</TD><TD STYLE="padding: 10px 0px 0px">' + CustomerName + '</TD></TR>\n',
			'<TR><TD>' + ChiefTitle + ' ' + ChiefName + '</TD><TD></TD></TR>\n',
			'<TR><TD><DIV CLASS="UnderLine"></DIV></TD>\n',
			'<TD><DIV CLASS="UnderLine"></DIV></TD></TR>\n</TABLE>\n',
			'<DIV CLASS="EventInfo">' + BranchLocality + ', ' + EndDate + '</DIV></DIV>\n'
		];
		block.push(footer.join(""));
	}
	Body.push(block.join(""));
}
rs.Close();
Connect.Close();
ResponseText.push(Body.join(Divider));
ResponseText.push('</BODY></HTML>');
Response.Write(ResponseText.join(""))%>