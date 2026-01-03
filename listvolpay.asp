<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE VIRTUAL="Solaren/Set/list.set" -->
<% var Authorized = User.RoleId == 1,
Form = Solaren.Parse(),
BegMonth = String(Form.BegMonth),
EndMonth = String(Form.EndMonth);
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("ListVolPay");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("BegMonth", adVarChar, adParamInput, 10, BegMonth));
			Append(CreateParameter("EndMonth", adVarChar, adParamInput, 10, EndMonth));
		}
	}
	var rs = Solaren.Execute("ListVolPay");
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
		for (var rows = []; !rs.EOF; rs.MoveNext()) {
			var	td = [Tag.Write("TD", -1, rs.Fields("CustomerName")),
				Tag.Write("TD", -1, rs.Fields("ContractPAN")),
				Tag.Write("TD", -1, rs.Fields("CustomerAddress")),
				Tag.Write("TD", -1, rs.Fields("ContractDate")),
				Tag.Write("TD", 2, rs.Fields("ContractPower").Value.toDelimited(2)),
				Tag.Write("TD", 2, rs.Fields("RetVol").Value.toDelimited(0)),
				Tag.Write("TD", 2, rs.Fields("PurVol").Value.toDelimited(0)),
				Tag.Write("TD", 2, rs.Fields("PaySum").Value.toDelimited(2))
			],
			tr = Tag.Write("TR", -1, td.join(""));
			rows.push(tr);
			this.TotPwr    += rs.Fields("ContractPower");
			this.TotRetVol += rs.Fields("RetVol");
			this.TotPurVol += rs.Fields("PurVol");
			this.TotPaySum += rs.Fields("PaySum");
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
Solaren.Close();
Response.Write(Output)%>


