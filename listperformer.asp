<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/list.set" -->
<% var Authorized = User.RoleId == 1,
Form = Webserver.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("ListPerformer");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("PerformerName", adVarChar, adParamInput, 10, Form.PerformerName));
		}
	}
	var rs = Solaren.Execute("ListPerformer");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Виконавці");
}

var Table = {
	GetRows: function(rs) {
		for (var rows = []; !rs.EOF; rs.MoveNext()) {
			var url = Html.GetLink("editperformer.asp?PerformerId=", rs.Fields("Id"), rs.Fields("UserName")),
			td = [Tag.Write("TD", 0, url),
				Tag.Write("TD", 0, rs.Fields("FullName")),
				Tag.Write("TD", 0, rs.Fields("Phone")),
				Tag.Write("TD", 0, rs.Fields("BranchName"))
			],
			tr = Tag.Write("TR", -1, td.join(""));
			rows.push(tr);
		}
		return rows;
	},

	Render: function(rs) {
        var rows = this.GetRows(rs),
		Header = ['Логін', 'ПIБ', 'Телефон', 'ЦОС'],
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

