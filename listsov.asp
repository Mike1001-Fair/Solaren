<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE VIRTUAL="Solaren/Set/list.set" -->
<% var Authorized = User.RoleId == 1,
Form = Webserver.Parse(),
ReportMonth = String(Form.ReportMonth),
Filter = Form.Filter == "on";
User.CheckAccess(Authorized, "POST");

try {
	Db.SetCmd("ListSov");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("ReportMonth", adVarChar, adParamInput, 10, ReportMonth));
			Append(CreateParameter("Filter", adBoolean, adParamInput, 1, Filter));
		}
	}
	var rs = Db.Execute("ListSov");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetHead("Баланс");
}

var Table = {
	TotS: 0,
	TotObDt: 0,
	TotObCt: 0,
	TotPurVol: 0,
	TotSEnd:0,

	GetRows: function(rs) {
		var f = rs.Fields;
		for (var row = []; !rs.EOF; rs.MoveNext()) {
			var td = [Tag.Write("TD", -1, f("CustomerName").Value),
				Tag.Write("TD", 2, f("ContractPAN").Value),
				Tag.Write("TD", 2, f("s").Value.toDelimited(2)),
				Tag.Write("TD", 2, f("PurVol").Value.toDelimited(0)),
				Tag.Write("TD", 2, f("ob_dt").Value.toDelimited(2)),
				Tag.Write("TD", 2, f("ob_ct").Value.toDelimited(2)),
				Tag.Write("TD", 2, f("s_end").Value.toDelimited(2))
			],
			tr = Tag.Write("TR", -1, td.join(""));
            row.push(tr);
			this.TotS      += f("s").Value;
			this.TotPurVol += f("PurVol").Value;
			this.TotObDt   += f("ob_dt").Value;
			this.TotObCt   += f("ob_ct").Value;
			this.TotSEnd   += f("s_end").Value;			
		}
		return row
	},

	GetFooter: function(total) {
		var th = ['<TH ALIGN="LEFT" COLSPAN="2">Всього: ' + total, '</TH>',
			Tag.Write("TH", 2, this.TotS.toDelimited(2)),
			Tag.Write("TH", 2, this.TotPurVol.toDelimited(0)),
			Tag.Write("TH", 2, this.TotObDt.toDelimited(2)),
			Tag.Write("TH", 2, this.TotObCt.toDelimited(2)),
			Tag.Write("TH", 2, this.TotSEnd.toDelimited(2)),
		],
		tr = Tag.Write("TR", -1, th.join("")),
		footer = [tr, '</TABLE></BODY></HTML>'];
		return footer.join("\n")
	},

	Render: function(rs) {
		var Header = ["Споживач", "Рахунок", "Сальдо<BR>на початок", "Обсяг<BR>кВт&#183;год", "Вартiсть", "Оплата", "Сальдо<BR>на кiнець"],
		Period = Month.GetPeriod(ReportMonth, 0),
		rows = this.GetRows(rs),
		Body = ['<BODY CLASS="PrnBody">',
			'<H3 CLASS="H3PrnTable">' + Html.Title + '</H3>',
			'<SPAN CLASS="H3PrnTable">перiод: ' + Period + '</SPAN>',
			'<TABLE CLASS="PrnTable">',
			Html.GetHeadRow(Header),
			rows.join("\n"),
			this.GetFooter(rows.length)
		];
		return Body.join("\n")
	}
},
Output = Table.Render(rs);
rs.Close();
Db.Close();
Response.Write(Output)%>