<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/list.set" -->
<% var Authorized = User.RoleId < 2,
Form = Webserver.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("ListBranch");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("BranchName", adVarChar, adParamInput, 10, Form.BranchName));
		}
	}
	var rs = Solaren.Execute("ListBranch");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Список ЦОС");
}

var Table = {
	GetRows: function(rs) {
		for (var rows = []; !rs.EOF; rs.MoveNext()) {
			var url = Html.GetLink("editbranch.asp?BranchId=", rs.Fields("BranchId"), rs.Fields("BranchName")),
			td = [Tag.Write("TD", 2, rs.Fields("SortCode")),
				Tag.Write("TD", -1, url),
				Tag.Write("TD", -1, rs.Fields("ChiefName")),
				Tag.Write("TD", -1, rs.Fields("Accountant"))
			],
			tr = Tag.Write("TR", -1, td.join(""));
			rows.push(tr);
		}
		return rows;
	},

	Render: function(rs) {
		var rows = this.GetRows(rs),
		Header = ['№', 'Назва', 'Керiвник', 'Бухгалтер'],
		body = [
			'<BODY CLASS="MainBody">',
			'<H3 CLASS="H3Text">' + Html.Title + '</H3>',
			'<TABLE CLASS="InfoTable">',
 			Html.GetHeadRow(Header),
			rows.join("\n"),
			Html.GetFooterRow(Header.length, rows.length)
		];
        return body.join("\n");
	}
},
Output = Table.Render(rs);
rs.Close();
Solaren.Close();
Response.Write(Output)%>


