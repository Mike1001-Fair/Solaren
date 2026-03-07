<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/list.set" -->
<% var Authorized = User.RoleId == 2,
Form = Webserver.Parse(),
ReportMonth = String(Form.ReportMonth),
DoubleReport = Form.DoubleReport == "on";
User.CheckAccess(Authorized, "POST");

try {
	Db.SetCmd("GetReportInfo");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("ContractId", adInteger, adParamInput, 10, Form.ContractId));
		}
	}
	var rsInfo = Db.Execute("GetReportInfo");
	Cmd.Parameters.Append(Cmd.CreateParameter("ReportMonth", adVarChar, adParamInput, 10, ReportMonth));
	var rs = Db.Execute("GetIndicatorReport");
} catch (ex) {
	Message.Write(3, Message.Error(ex));
} finally {
	var Report = Webserver.Map(rsInfo.Fields);
	rsInfo.Close();
	Html.SetHead("Звіт про показники");
}

var Doc = {
	getText: function(totSaldo) {
		var resultText = ["За результатами знятих показникiв: "],
		s = " електроенергiю, згiдно умов договору ";
		if (totSaldo) {
			if (totSaldo < 0) {
				totSaldo = Math.abs(totSaldo);
				resultText.push("Постачальник оплачує Споживачу" + s + "купiвлі-продажу електричної енергiї")
			} else {
				resultText.push("Споживач оплачує Постачальнику" + s + "про постачання електричної енергiї");
			}
			resultText.push(", в обсязi " + totSaldo.toDelimited(0) + " кВт&#183;год.")
		}
		return resultText.join("")
	},

	Render: function(DoubleReport) {
		var Body = [],
		Divider = '<DIV CLASS="BlockDivider"></DIV>\n',
		Output = Table.Render(rs),
		copies = DoubleReport ? 2 : 1;
		for (var i = 0; i < copies; i++) {
 			Body.push(Output);
		}
		return Body.join(Divider)
	}
},

Table = {
	totSaldo: 0,

	GetRows: function(rs) {
		var f = rs.Fields;
		for (var tr=[]; !rs.EOF; rs.MoveNext()) {
			var k = f("kTransForm").Value,
			c = f("Capacity").Value,
			PrevDate = Month.GetYMD(f("PrevDate").Value),
			ReportDate = Month.GetYMD(f("ReportDate").Value),
			recsaldo = f("RecVal").Value - f("PrevRecVal").Value,
			retsaldo = f("RetVal").Value - f("PrevRetVal").Value,
			periodSaldo;

			if (recsaldo < 0) recsaldo += Math.pow(10, c);
			if (retsaldo < 0) retsaldo += Math.pow(10, c);

			periodSaldo = (recsaldo - retsaldo) * k;
			this.totSaldo += periodSaldo;

            var td = [
				Tag.Write("TD", 1, f("MeterCode").Value) +
				Tag.Write("TD", 1, "Прийом А+") +
				Tag.Write("TD", 2, f("RecVal").Value) +
				Tag.Write("TD", 2, f("PrevRecVal").Value) +
				Tag.Write("TD", 2, recsaldo) +
				Tag.Write("TD", 1, k) +
				Tag.Write("TD", 2, recsaldo * k),

				Tag.Write("TD", 1, f("MeterCode").Value) +
				Tag.Write("TD", 1, "Видача А-") +
				Tag.Write("TD", 2, f("RetVal").Value) +
				Tag.Write("TD", 2, f("PrevRetVal").Value) +
				Tag.Write("TD", 2, retsaldo) +
				Tag.Write("TD", 1, k) +
				Tag.Write("TD", 2, retsaldo * k),

				'<TD ALIGN="LEFT" COLSPAN="6">Сальдо з ' + PrevDate.formatDate("-") + ' по ' + ReportDate.formatDate("-") + '</TD>' +
				Tag.Write("TD", 2, periodSaldo)
			];

			for (var j = 0; j < td.length; j++) {
				tr.push(Tag.Write("TR", -1, td[j]));
			}
		}
		return tr;
	},

	GetFooter: function() {
		var	BranchLocality = [Locality.Type[Report.BranchLocalityType], Report.BranchLocalityName],
		EndDate = Month.GetLastDay(ReportMonth),
		footer = ['</TABLE>',
			Tag.Write('P', -1, Doc.getText(this.totSaldo)),
			'<TABLE CLASS="NoBorderTable">',
			'<TR><TD WIDTH="50%">Постачальник:</TD><TD WIDTH="50%">Споживач:</TD></TR>',
            '<TR><TD STYLE="padding: 10px 0px 0px">' + Report.BranchName + ' ЦОС</TD><TD STYLE="padding: 10px 0px 0px">' + Report.CustomerName + '</TD></TR>',
            '<TR><TD>' + Report.ChiefTitle + ' ' + Report.ChiefName + '</TD><TD></TD></TR>',
			'<TR><TD><DIV CLASS="UnderLine"></DIV></TD>',
			'<TD><DIV CLASS="UnderLine"></DIV></TD></TR>',
			'</TABLE>',
			'<DIV CLASS="EventInfo">' + BranchLocality.join(" ") + ', ' + EndDate + '</DIV></DIV>'
		];
		return footer
	},

	Render: function(rs) {
		var Period   = Month.GetPeriod(ReportMonth, 1),
		ContractDate = Month.GetYMD(Report.ContractDate),		
		EndDate      = Month.GetLastDay(ReportMonth),
		LocalityType = Locality.Type[Report.ContractLocalityType],
		StreetType   = Street.Type[Report.ContractStreetType],
		ContractAddress = [LocalityType, Report.ContractLocalityName + ", ", StreetType, Report.ContractStreetName, Report.HouseId],
		Caption = ['Споживач: ' + Report.CustomerName, 'Рахунок: ' + Report.ContractPAN, 'Адреса: ' + ContractAddress.join(" ")],
		Ref = ['Додаток до договору купiвлi-продажу електричної енергiї за "зеленим" тарифом приватним домогосподарством вiд ', ContractDate.formatDate("-"), ' р.'],
		tr = this.GetRows(rs),
		footer = this.GetFooter(),
		body = ['<DIV CLASS="ActText">',
			'<TABLE CLASS="NoBorderTable">',
			'<TR><TD></TD><TD CLASS="ReportTitle">' + Ref.join("") + '</TD></TR>',
			'</TABLE>',
			'<H3 CLASS="H3PrnTable">Звiт</H3><SPAN>про показники лiчильника, обсяги та напрямки перетокiв електричної енергiї в ' + Period + '</SPAN>',
			'<TABLE CLASS="ActTable">',
			Tag.Write('CAPTION', -1, Caption.join('<BR>')),
			'<TR><TD ROWSPAN="2">№<BR>лiчильника</TD><TD ROWSPAN="2">Вид<BR>вимiрювання</TD><TD COLSPAN="2">Показники</TD>' +
			'<TD ROWSPAN="2">Рiзниця</TD><TD ROWSPAN="2">Коефiцiєнт<BR>трансформацiї</TD><TD>Всього</TD></TR>',
			'<TR><TD>останнi</TD><TD>попереднi</TD><TD>кВт&#183;год</TD></TR>',
			tr.join("\n"),
			footer.join("\n")
		];
		return body.join("\n");
	}
},

Output = ['\n<BODY CLASS="ActContainer">',
	Doc.Render(DoubleReport),
	'</BODY></HTML>'
];

rs.Close();
Db.Close();
Response.Write(Output.join("\n"))%>