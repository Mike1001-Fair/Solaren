<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/list.set" -->
<% var Authorized = User.RoleId == 1,
Form = Webserver.Parse(),
ReportMonth = String(Form.ReportMonth),
//AveragePrice = String(Form.AveragePrice);
AveragePrice = parseFloat(Form.AveragePrice) || 0;
User.CheckAccess(Authorized, "POST");

try {
	Db.SetCmd("ListCompensation");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adInteger, adParamInput, 10, User.Id));
			Append(CreateParameter("ReportMonth", adVarChar, adParamInput, 10, ReportMonth));
		}
	}
	var rs = Db.Execute("ListCompensation");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetHead("Компенсація");
}

var Doc = {
	TotRetVol: 0,
	TotRecVol: 0,
	TotPurVol: 0,
	TotCompensation: 0,

	GetRows: function(rs) {
		var f = rs.Fields;
		for (var row = []; !rs.EOF; rs.MoveNext()) {
			var Compensation = Math.round(f("PurVol").Value * (f("Tarif").Value	- AveragePrice))/100,
			td = [Tag.Write("TD", 2, f("ContractPAN").Value),
				Tag.Write("TD", -1, f("BegDate").Value),
				Tag.Write("TD", -1, f("EndDate").Value),
				Tag.Write("TD", -1, f("CustomerName").Value),
				Tag.Write("TD", -1, f("EICode").Value),
				Tag.Write("TD", 2, f("Tarif").Value.toDelimited(2)),
				Tag.Write("TD", 2, f("RetVol").Value.toDelimited(0)),
				Tag.Write("TD", 2, f("RecVol").Value.toDelimited(0)),
				Tag.Write("TD", 2, f("PurVol").Value.toDelimited(0)),
				Tag.Write("TD", 2, Compensation.toDelimited(2))
			],
			tr = Tag.Write("TR", -1, td.join(""));
            row.push(tr);
			this.TotRetVol += f("RetVol").Value;
			this.TotRecVol += f("RecVol").Value;
			this.TotPurVol += f("PurVol").Value;
			this.TotCompensation += Compensation;
		}
		return row
	},

	GetFooter: function(total) {
		var th = ['<TH ALIGN="LEFT" COLSPAN="6">Всього: ' + total,
			Tag.Write("TH", 2, this.TotRetVol.toDelimited(0)),
			Tag.Write("TH", 2, this.TotRecVol.toDelimited(0)),
			Tag.Write("TH", 2, this.TotPurVol.toDelimited(0)),
			Tag.Write("TH", 2, this.TotCompensation.toDelimited(2))
		],
		tr = Tag.Write("TR", -1, th.join("")),
		footer = [tr, '</TABLE></BODY></HTML>'];
		return footer.join("\n")
	},

	Render: function(rs) {
		var Period = Month.GetPeriod(ReportMonth, 0),
		avgPrice = AveragePrice.toDelimited(6).replace(".", ","),
		Caption = ['Середньозважена ціна:', avgPrice, 'коп.'],
		Header   = ['З', 'По', 'коп', 'Видача', 'Потреби', 'Покупка', '&#8372;'],
		tr = this.GetRows(rs),
		Body = ['\n<BODY CLASS="PrnBody">',
			'<H3 CLASS="H3PrnTable">Компенсація</H3><SPAN CLASS="H3PrnTable">перiод: ' + Period + '</SPAN>',
			'<TABLE CLASS="PrnTable">',
			Tag.Write("CAPTION", -1, Caption.join(" ")),
			'<TR><TH ROWSPAN="2">Рахунок</TH><TH COLSPAN="2">Період</TH><TH ROWSPAN="2">Споживач</TH><TH ROWSPAN="2">EIC</TH><TH>Тариф</TH>	<TH COLSPAN="3">кВт&#183;год</TH><TH>Компенсація</TH></TR>',
			Html.GetHeadRow(Header),
			tr.join("\n"),
			this.GetFooter(tr.length),
		];
		return Body.join("\n")
	}
},
Output = Doc.Render(rs);
rs.Close();
Db.Close();
Response.Write(Output)%>