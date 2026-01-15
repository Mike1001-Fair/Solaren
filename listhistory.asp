<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/list.set" -->
<% var Authorized = User.RoleId == 1,
Form = Webserver.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("ListHistory");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("ContractId", adVarChar, adParamInput, 10, Form.ContractId));
			Append(CreateParameter("BegMonth", adVarChar, adParamInput, 10, Form.BegMonth));
			Append(CreateParameter("EndMonth", adVarChar, adParamInput, 10, Form.EndMonth));
		}
	}
	var rs = Solaren.Execute("ListHistory");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetHead("Iсторiя розрахункiв")
}

var Table = {
	TotObDt: 0,
	TotObCt: 0,
	TotPurVol: 0,

	GetRows: function(rs) {
		for (var row = []; !rs.EOF; rs.MoveNext()) {
			var td = [Tag.Write("TD", -1, rs.Fields("ReportPeriod")),
				Tag.Write("TD", 2, rs.Fields("s").Value.toDelimited(2)),
				Tag.Write("TD", 2, rs.Fields("PurVol").Value.toDelimited(0)),
				Tag.Write("TD", 2, rs.Fields("ob_dt").Value.toDelimited(2)),
				Tag.Write("TD", 2, rs.Fields("ob_ct").Value.toDelimited(2))
			],
			tr = Tag.Write("TR", -1, td.join(""));
            row.push(tr);
			this.TotPurVol += rs.Fields("PurVol").Value;
			this.TotObDt   += rs.Fields("ob_dt").Value;
			this.TotObCt   += rs.Fields("ob_ct").Value;
		}
		return row
	},

	GetFooter: function(total) {
		var th = ['<TH ALIGN="LEFT" COLSPAN="2">Всього: ' + total, '</TH>',
			Tag.Write("TH", 2, this.TotPurVol.toDelimited(0)),
			Tag.Write("TH", 2, this.TotObDt.toDelimited(2)),
			Tag.Write("TH", 2, this.TotObCt.toDelimited(2))
		],
		tr = Tag.Write("TR", -1, th.join("")),
		footer = [tr, '</TABLE></BODY></HTML>'];
		return footer.join("\n")
	},

	Render: function(rs) {
		var Header = ['Перiод', 'Сальдо', 'Обсяг', 'Вартiсть', 'Оплата'],
		rows = this.GetRows(rs),
		Body = ['<BODY CLASS="PrnBody">',
			'<H3 CLASS="H3PrnTable">Iсторiя розрахункiв</H3><SPAN CLASS="H3PrnTable">' + Form.ContractName + '</SPAN>',
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
Solaren.Close();
Response.Write(Output)%>