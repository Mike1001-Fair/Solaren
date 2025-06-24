<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 0,
Form = Solaren.Map(Request.Form);
User.ValidateAccess(Authorized, "POST");

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

var Header = ['Логiн', 'Роль', 'Ip', 'Пiдключився', 'Агент'],
ResponseText = ['<BODY CLASS="MainBody">',
	'<H3 CLASS="H3Text">' + Html.Title + '</H3>',
	'<TABLE CLASS="InfoTable">',
	Html.GetHeadRow(Header)
];

for (var i=0; !rs.EOF; i++) {
	var url = Html.GetLink("edituser.asp?UserId=", rs.Fields("Id"), rs.Fields("UserName")),
	td = [Tag.Write("TD", -1, url),
		Tag.Write("TD", -1, User.Role[rs.Fields("RoleId")]),
		Tag.Write("TD", 1, rs.Fields("UserIP")),
		Tag.Write("TD", -1, rs.Fields("LastLogin")),
		Tag.Write("TD", -1, rs.Fields("UserAgent"))
	],
	tr = Tag.Write("TR", -1, td.join(""));
	ResponseText.push(tr);
	rs.MoveNext();
}
rs.Close();
Solaren.Close();
ResponseText.push(Html.GetFooterRow(5, i));
Response.Write(ResponseText.join("\n"))%>
