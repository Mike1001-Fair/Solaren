<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 0;
User.ValidateAccess(Authorized, "POST");

with (Request) {
	var LoginId = Form("LoginId"),
	RoleId      = Form("RoleId"),
	ConnectDate = Form("ConnectDate");
}

try {
	Solaren.SetCmd("ListUsers");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("LoginId", adVarChar, adParamInput, 20, LoginId));
			Append(CreateParameter("RoleId", adVarChar, adParamInput, 10, RoleId));
			Append(CreateParameter("SessionId", adInteger, adParamInput, 10, Session.SessionID));
			Append(CreateParameter("ConnectDate", adVarChar, adParamInput, 20, ConnectDate));
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
	var url = Html.GetLink("edituser.asp?UserId=", rs.Fields("Id"), rs.Fields("LoginId")),
	row = [Tag.Write("TD", -1, url),
		Tag.Write("TD", -1, User.Role[rs.Fields("RoleId")]),
		Tag.Write("TD", 1, rs.Fields("UserIP")),
		Tag.Write("TD", -1, rs.Fields("LastLogin")),
		Tag.Write("TD", -1, rs.Fields("UserAgent"))
	],
	tr = Tag.Write("TR", -1, row.join(""));
	ResponseText.push(tr);
	rs.MoveNext();
}
rs.Close();
Solaren.Close();
ResponseText.push(Html.GetFooterRow(5, i));
Response.Write(ResponseText.join("\n"))%>

