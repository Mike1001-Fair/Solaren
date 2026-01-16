<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE VIRTUAL="Solaren/Set/list.set" -->
<% var Authorized = User.RoleId == 1;
Form = Webserver.Parse(),
BegDate = String(Form.BegDate),
EndDate = String(Form.EndDate);
User.CheckAccess(Authorized, "POST");

try {
	Db.SetCmd("ListPay");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adInteger, adParamInput, 10, User.Id));
			Append(CreateParameter("BegDate", adVarChar, adParamInput, 10, BegDate));
			Append(CreateParameter("EndDate", adVarChar, adParamInput, 10, EndDate));
			Append(CreateParameter("ContractId", adInteger, adParamInput, 10, Form.ContractId));
		}
	}
	var rs = Db.Execute("ListPay");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Список оплат")
}

var Table = {
	TotSum: 0,

	GetRows: function(rs) {
		for (var rows = []; !rs.EOF; rs.MoveNext()) {
			var url = Html.GetLink("editpay.asp?PayId=", rs.Fields("PayId"), rs.Fields("PaySum").Value.toDelimited(2)),
			PayDate = Month.GetYMD(rs.Fields("PayDate").Value),
			td = [Tag.Write("TD", -1, PayDate.formatDate("-")),
				Tag.Write("TD", 2, url)
			],
			tr = Tag.Write("TR", -1, td.join(""));
			rows.push(tr);
			this.TotSum += rs.Fields("PaySum").Value;
		}
		return rows;
	},

	GetFooter: function(total) {
		var th = [Tag.Write("TH", 0, 'Всього: ' + total),
			Tag.Write("TH", 2, this.TotSum.toDelimited(2))
		],
		tr = Tag.Write("TR", -1, th.join("")),
		footer = [tr, '</TABLE></BODY></HTML>'];
		return footer.join("\n")
	},

	Render: function(rs) {
		var Header = ['Дaта', 'Сума'],
		range = Month.GetRange(BegDate, EndDate),
		rows = this.GetRows(rs),		
		body = ['<BODY CLASS="MainBody">',
			'<TABLE CLASS="H3Text">',
			Tag.Write("CAPTION", -1, Html.Title),
			'<TR>' + Tag.Write("TD", 2, 'Споживач:') + Tag.Write("TD", 0, Form.ContractName) + '</TR>',
			'<TR>' + Tag.Write("TD", 2, 'Період:') + Tag.Write("TD", 0, range) + '</TR>',
			'</TABLE>',
			'<TABLE CLASS="InfoTable">',
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
