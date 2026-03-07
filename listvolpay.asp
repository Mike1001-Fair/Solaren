<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE VIRTUAL="Solaren/Set/list.set" -->
<% var Authorized = User.RoleId == 1,
Form = Webserver.Parse(),
BegMonth = String(Form.BegMonth),
EndMonth = String(Form.EndMonth);
User.CheckAccess(Authorized, "POST");

try {
	Db.SetCmd("ListVolPay");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("BegMonth", adVarChar, adParamInput, 10, BegMonth));
			Append(CreateParameter("EndMonth", adVarChar, adParamInput, 10, EndMonth));
		}
	}
	var rs = Db.Execute("ListVolPay");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetHead("Енергозбереження");
}

var Table = {
	TotPwr: 0,
	TotRetVol: 0,
	TotPurVol: 0,
	TotPaySum: 0,

	GetRows: function(rs) {
		var f = rs.Fields;
		for (var rows = []; !rs.EOF; rs.MoveNext()) {
			var	td = [Tag.Write("TD", -1, f("CustomerName").Value),
				Tag.Write("TD", -1, f("ContractPAN").Value),
				Tag.Write("TD", -1, f("CustomerAddress").Value),
				Tag.Write("TD", -1, f("ContractDate").Value),
				Tag.Write("TD", 2, f("ContractPower").Value.toDelimited(2)),
				Tag.Write("TD", 2, f("RetVol").Value.toDelimited(0)),
				Tag.Write("TD", 2, f("PurVol").Value.toDelimited(0)),
				Tag.Write("TD", 2, f("PaySum").Value.toDelimited(2))
			],
			tr = Tag.Write("TR", -1, td.join(""));
			rows.push(tr);
			this.TotPwr    += f("ContractPower").Value;
			this.TotRetVol += f("RetVol").Value;
			this.TotPurVol += f("PurVol").Value;
			this.TotPaySum += f("PaySum").Value;
		}
		return rows;
	},

	GetFooter: function(total) {
		var th = ['<TH ALIGN="LEFT" COLSPAN="4">Всього: ' + total, '</TH>',
			Tag.Write("TH", 2, this.TotPwr.toDelimited(2)),
			Tag.Write("TH", 2, this.TotRetVol.toDelimited(0)),
			Tag.Write("TH", 2, this.TotPurVol.toDelimited(0)),
			Tag.Write("TH", 2, this.TotPaySum.toDelimited(2))
		],
		tr = Tag.Write("TR", -1, th.join("")),
		footer = [tr, '</TABLE></BODY></HTML>'];
		return footer.join("\n")
	},

	Render: function(rs) {
		var rows = this.GetRows(rs),
		Range = Month.GetRange(BegMonth, EndMonth),
		Header = ['Споживач', 'Рахунок', 'Адреса', 'Дата', 'Потужнiсть<BR>кВт', 'Видача<BR>кВт&#183;год', 'Покупка<BR>кВт&#183;год', 'Оплата<BR>&#8372;'],
		body = ['<BODY CLASS="PrnBody">',
			'<H3 CLASS="H3PrnTable">' + Html.Title + '</H3>',
			'<SPAN CLASS="H3PrnTable">перiод: ' + Range + '</SPAN>',
			'<TABLE CLASS="PrnTable">',
 			Html.GetHeadRow(Header),
			rows.join("\n"),
			this.GetFooter(rows.length)
		];
        return body.join("\n");
	}
},
Output = Table.Render(rs);
rs.Close();
Db.Close();
Response.Write(Output)%>