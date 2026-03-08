<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/list.set" -->
<% var Authorized = User.RoleId == 0,
Form = Webserver.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Db.SetCmd("ListUsers");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("UserName", adVarChar, adParamInput, 20, Form.UserName));
			Append(CreateParameter("RoleId", adVarChar, adParamInput, 10, Form.RoleId));
			Append(CreateParameter("SessionId", adInteger, adParamInput, 10, Session.SessionID));
			Append(CreateParameter("ConnectDate", adVarChar, adParamInput, 20, Form.ConnectDate));
		}
	}
	var rs = Db.Execute("ListUsers");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Користувачi");
}

var Table = {
	GetRows: function(rs) {
		var f = rs.Fields;
		for (var rows = []; !rs.EOF; rs.MoveNext()) {
			var url = Html.GetLink("edituser.asp?UserId=", f("Id").Value, f("UserName").Value),
			td = [Tag.Write("TD", -1, url),
				Tag.Write("TD", -1, User.Role[f("RoleId").Value]),
				Tag.Write("TD", 1, f("UserIP").Value),
				Tag.Write("TD", -1, f("LastLogin").Value),
				Tag.Write("TD", -1, f("UserAgent").Value)
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
Db.Close();
Response.Write(Output)%>