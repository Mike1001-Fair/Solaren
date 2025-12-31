<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Include/list.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
Form = Solaren.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("ListRegion");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("RegionName", adVarChar, adParamInput, 10, Form.RegionName));
		}
	}
	var rs = Solaren.Execute("ListRegion");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Області")
}

var Table = {
	GetRows: function(rs) {
		for (var rows = []; !rs.EOF; rs.MoveNext()) {
			var url = Html.GetLink("editregion.asp?RegionId=", rs.Fields("Id"), rs.Fields("RegionName")),
			td = [Tag.Write("TD", -1, rs.Fields("SortCode")),
				Tag.Write("TD", -1, url)
			],
			tr = Tag.Write("TR", -1, td.join(""));
			rows.push(tr);
		}
		return rows;
	},

	Render: function(rs) {
		var rows = this.GetRows(rs),
		Header = ['№', 'Назва'],
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


