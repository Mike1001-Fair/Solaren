<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Include/list.inc" -->
<% var Authorized = User.RoleId == 1;
Form = Solaren.Parse(),
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("ListMeter");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("ContractId", adVarChar, adParamInput, 10, Form.ContractId));
			Append(CreateParameter("MeterCode", adVarChar, adParamInput, 10, Form.MeterCode));
		}
	}
	var rs = Solaren.Execute("ListMeter");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Список лiчильникiв")
}

var Table = {
	GetRows: function(rs) {
		for (var rows = []; !rs.EOF; rs.MoveNext()) {
			var url = Html.GetLink("editmeter.asp?MeterId=", rs.Fields("Id"), rs.Fields("Code")),
			td = [Tag.Write("TD", 9, rs.Fields("PAN")),
				Tag.Write("TD", 0, rs.Fields("CustomerName")),
				Tag.Write("TD", 2, url),
				Tag.Write("TD", -1, rs.Fields("SetDate")),
				Tag.Write("TD", -1, rs.Fields("Capacity")),
				Tag.Write("TD", -1, rs.Fields("kTransForm")),
				Tag.Write("TD", -1, rs.Fields("RecVal")),
				Tag.Write("TD", -1, rs.Fields("RetVal"))
			],
			tr = Tag.Write("TR", -1, td.join(""));
			rows.push(tr);
		}
		return rows;
	},

	Render: function(rs) {
		var rows = this.GetRows(rs),
		Header = ['Номер', 'Монтаж', 'Р', 'К', 'Прийом', 'Видача'],
		Body = ['<BODY CLASS="MainBody">',
			'<H3 CLASS="H3Text">' + Html.Title + '</H3>',
			'<TABLE CLASS="InfoTable">',
			'<TR><TH ROWSPAN="2">Рахунок</TH><TH ROWSPAN="2">Споживач</TH><TH COLSPAN="6">Лічильник</TH></TR>',
			Html.GetHeadRow(Header),
			rows.join("\n"),
			Html.GetFooterRow(8, rows.length)
		];
		return Body.join("\n");
	}
},
Output = Table.Render(rs);
rs.Close();
Solaren.Close();
Response.Write(Output)%>
