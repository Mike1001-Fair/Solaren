<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/list.set" -->

<% var Authorized = User.RoleId == 0,
Form = Solaren.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("ListUsers");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("UserName", adVarChar, adParamInput, 20, Form.UserName));
			Append(CreateParameter("RoleId", adVarChar, adParamInput, 10, Form.RoleId));
			Append(CreateParameter("SessionId", adInteger, adParamInput, 10, Session.SessionID));
			Append(CreateParameter("ConnectDate", adVarChar, adParamInput, 20, Form.ConnectDate));
		}
	}
	var rs = Solaren.Execute("ListUsers");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Користувачi");
}

var Table = {
	GetRows: function(rs) {
		for (var rows = []; !rs.EOF; rs.MoveNext()) {
			var url = Html.GetLink("edituser.asp?UserId=", rs.Fields("Id"), rs.Fields("UserName")),
			td = [Tag.Write("TD", -1, url),
				Tag.Write("TD", -1, User.Role[rs.Fields("RoleId")]),
				Tag.Write("TD", 1, rs.Fields("UserIP")),
				Tag.Write("TD", -1, rs.Fields("LastLogin")),
				Tag.Write("TD", -1, rs.Fields("UserAgent"))
			],
			tr = Tag.Write("TR", -1, td.join(""));
			rows.push(tr);			
		}
		return rows;
	},

	Render: function(rs) {
		var rows = this.GetRows(rs),
		Header = ['Логiн', 'Роль', 'Ip', 'Пiдключився', 'Агент'],
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
