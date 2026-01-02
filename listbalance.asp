<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE VIRTUAL="Solaren/Set/list.set" -->
<% var Authorized = User.RoleId == 1,
Form = Solaren.Parse(),
BegMonth = String(Form.BegMonth),
EndMonth = String(Form.EndMonth);
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("ListBalance");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("BegMonth", adVarChar, adParamInput, 10, BegMonth));
			Append(CreateParameter("EndMonth", adVarChar, adParamInput, 10, EndMonth));
			Append(CreateParameter("OperatorId", adVarChar, adParamInput, 10, Form.OperatorId));
		}
	}
	var rs = Solaren.Execute("ListBalance");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetHead("Баланс", 0);
}

var Table = {
	TotRetVol: 0,
	TotPurVol: 0,
	TotNeedVol: 0,

	GetRows: function(rs) {
		for (var row = []; !rs.EOF; rs.MoveNext()) {
			var td = [Tag.Write("TD", -1, rs.Fields("AenName")),
				Tag.Write("TD", 2, rs.Fields("RetVol").Value.toDelimited(0)),
				Tag.Write("TD", 2, rs.Fields("PurVol").Value.toDelimited(0)),
				Tag.Write("TD", 2, rs.Fields("NeedVol").Value.toDelimited(0))
			];
			tr = Tag.Write("TR", -1, td.join(""));
            row.push(tr);
			this.TotRetVol += rs.Fields("RetVol");
			this.TotPurVol += rs.Fields("PurVol");
			this.TotNeedVol += rs.Fields("NeedVol");
		}
		return row
	},

	GetFooter: function(total) {
		var th = ['<TH ALIGN="LEFT">Всього: ' + total, '</TH>',
			Tag.Write("TH", 2, this.TotRetVol.toDelimited(0)),
			Tag.Write("TH", 2, this.TotPurVol.toDelimited(0)),
			Tag.Write("TH", 2, this.TotNeedVol.toDelimited(0)),
		],
		tr = Tag.Write("TR", -1, th.join("")),
		footer = [tr, '</TABLE></BODY></HTML>'];
		return footer.join("\n")
	},

	Render: function(rs) {
		var Header = ['РЕМ', 'Видача', 'Покупка', 'Потреби'],
		Range = Month.GetRange(BegMonth, EndMonth),
		rows = this.GetRows(rs),
		Body = ['<BODY CLASS="PrnBody">',
			'<H3 CLASS="H3PrnTable">Баланс</H3><SPAN CLASS="H3PrnTable">перiод: ' + Range + '</SPAN>',
			'<TABLE CLASS="PrnTable">',
			'<CAPTION>оператор: ' + Form.OperatorName + '</CAPTION>',
			Html.GetHeadRow(Header),
			rows.join("\n"),
			this.GetFooter(rows.length)
		];
		return Body.join("\n")
	}
},
Output = Table.Render(rs);
rs.Close();
Solaren.Close();
Response.Write(Output)%>

