<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE VIRTUAL="Solaren/Include/list.inc" -->
<% var Authorized = User.RoleId == 1;
User.CheckAccess(Authorized, "GET");

try {
	Solaren.SetCmd("ListNoTarif");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
		}
	}
	var rs = Cmd.Execute();
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	rs.EOF ? Message.Write(1, "Помилок не виявлено") : Html.SetPage("Обсяги");
}

var Table = {
	GetRows: function(rs) {
		for (var rows = []; !rs.EOF; rs.MoveNext()) {
			var	td = [Tag.Write("TD", -1, rs.Fields("CustomerName")),
				Tag.Write("TD", -1, rs.Fields("ContractPAN")),
				Tag.Write("TD", -1, rs.Fields("BegDate")),
				Tag.Write("TD", -1, rs.Fields("EndDate")),
				Tag.Write("TD", 2, rs.Fields("PurVol").Value.toDelimited(0)),
				Tag.Write("TD", 2, rs.Fields("VolCost").Value.toDelimited(2)),
				Tag.Write("TD", -1, rs.Fields("BranchName")),
			],
			tr = Tag.Write("TR", -1, td.join(""));
			rows.push(tr);
		}
		return rows;
	},

	Render: function(rs) {
        var rows = this.GetRows(rs),
		Header = ['Споживач', 'Рахунок', 'З', 'По', 'Обсяг<BR>кВт&#183;год', 'Вартiсть<BR>грн', 'ЦОС'],
		Body = ['<BODY CLASS="MainBody">',
			'<H3 CLASS="H3Text">' + Html.Title + '</H3>',
			'<TABLE CLASS="InfoTable">',
			Html.GetHeadRow(Header),
			rows.join("\n"),
			Html.GetFooterRow(Header.length, rows.length)
		];
        return Body.join("\n");
	}
},
Output = Table.Render(rs);
rs.Close();
Solaren.Close();
Response.Write(Output)%>


