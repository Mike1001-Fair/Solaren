<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = User.RoleId == 1;
Form = Solaren.Parse(),
BegDate = String(Form.BegDate),
EndDate = String(Form.EndDate);
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("ListPay");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adInteger, adParamInput, 10, User.Id));
			Append(CreateParameter("BegDate", adVarChar, adParamInput, 10, BegDate));
			Append(CreateParameter("EndDate", adVarChar, adParamInput, 10, EndDate));
			Append(CreateParameter("ContractId", adInteger, adParamInput, 10, Form.ContractId));
		}
	}
	var rs = Solaren.Execute("ListPay");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Список оплат")
}

var Table = {
	Header: ['Дaта', 'Сума'],
	TotSum: 0,

	GetRows: function(rs) {
		for (var rows = []; !rs.EOF;) {
			var url = Html.GetLink("editpay.asp?PayId=", rs.Fields("PayId"), rs.Fields("PaySum").Value.toDelimited(2)),
			PayDate = Month.GetYMD(rs.Fields("PayDate").Value),
			td =  [Tag.Write("TD", -1, PayDate.formatDate("-")),
				Tag.Write("TD", 2, url)
			],
			tr = Tag.Write("TR", -1, td.join(""));
			rows.push(tr);
			this.TotSum += rs.Fields("PaySum").Value;
			rs.MoveNext();
		}
		return rows;
	},

	Render: function(rs) {
		var range = Month.GetRange(BegDate, EndDate),
		rows = this.GetRows(rs),
		th = [Tag.Write("TH", 0, 'Всього: ' + rows.length),
			Tag.Write("TH", 2, this.TotSum.toDelimited(2))
		],
		footer = Tag.Write("TR", -1, th.join("")),
		body = ['<BODY CLASS="MainBody">',
			'<TABLE CLASS="H3Text">',
			Tag.Write("CAPTION", -1, Html.Title),
			'<TR>' + Tag.Write("TD", 2, 'Споживач:') + Tag.Write("TD", 0, Form.ContractName) + '</TR>',
			'<TR>' + Tag.Write("TD", 2, 'Період:') + Tag.Write("TD", 0, range) + '</TR>',
			'</TABLE>',
			'<TABLE CLASS="InfoTable">',
			Html.GetHeadRow(this.Header),
			rows.join("\n"),
			footer,
			'</TABLE></BODY></HTML>'
		];
		return body.join("\n");
	}
},
Output = Table.Render(rs);
rs.Close();
Solaren.Close();
Response.Write(Output);%>
