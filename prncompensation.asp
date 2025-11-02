<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1;
User.CheckAccess(Authorized, "POST");

with (Request) {
	var ReportMonth = String(Form("ReportMonth")),
	AveragePrice    = String(Form("AveragePrice")),
	ChiefId         = Form("ChiefId");
}

try {
	Solaren.SetCmd("ListCompensation");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adInteger, adParamInput, 10, User.Id));
			Append(CreateParameter("ReportMonth", adVarChar, adParamInput, 10, ReportMonth));
		}
	}
	var rs = Solaren.Execute("ListCompensation");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetHead("Компенсація");
}

var Doc = {
	Body: [],
	TotRetVol: 0,
	TotRecVol: 0,
	TotPurVol: 0,
	TotCompensation: 0,

	GetRows: function(rs) {
		for (var tr = []; !rs.EOF; rs.MoveNext()) {
			var Compensation = Math.round(rs.Fields("PurVol") * (rs.Fields("Tarif") - AveragePrice))/100,
			row = ['<TR>', Tag.Write("TD", 2, rs.Fields("ContractPAN")),
				Tag.Write("TD", -1, rs.Fields("BegDate")),
				Tag.Write("TD", -1, rs.Fields("EndDate")),
				Tag.Write("TD", -1, rs.Fields("CustomerName")),
				Tag.Write("TD", -1, rs.Fields("EICode")),

				Tag.Write("TD", 2, rs.Fields("Tarif").Value.toDelimited(2)),
				Tag.Write("TD", 2, rs.Fields("RetVol").Value.toDelimited(0)),
				Tag.Write("TD", 2, rs.Fields("RecVol").Value.toDelimited(0)),
				Tag.Write("TD", 2, rs.Fields("PurVol").Value.toDelimited(0)),
				Tag.Write("TD", 2, Compensation.toDelimited(2)), '</TR>'
			];
            tr.push(row.join(""));
			this.TotRetVol += rs.Fields("RetVol");
			this.TotRecVol += rs.Fields("RecVol");
			this.TotPurVol += rs.Fields("PurVol");
			this.TotCompensation += Compensation;
		}
		return tr
	},

	GetFooter: function(count) {
		var th = ['<TH ALIGN="LEFT" COLSPAN="6">Всього: ' + count,
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
		Caption = ['Середньозважена ціна: ', AveragePrice.replace(".", ","), ' коп.'],
		Header   = ['З', 'По', 'коп', 'Видача', 'Потреби', 'Покупка', '&#8372;'],
		tr = this.GetRows(rs),
		Body = ['\n<BODY CLASS="PrnBody">',
			'<H3 CLASS="H3PrnTable">Компенсація</H3><SPAN CLASS="H3PrnTable">перiод: ' + Period + '</SPAN>',
			'<TABLE CLASS="PrnTable">',
			Tag.Write("CAPTION", -1, Caption.join("")),
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
Solaren.Close();
Response.Write(Output)%>


