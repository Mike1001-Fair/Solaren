<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
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
	var rs = Solaren.Execute("ListUsers", "Iнформацiю не знайдено");
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
} finally {
	Html.SetPage("Користувачi", User.RoleId);
}

var Header = ['Логiн', 'Роль', 'Ip', 'Пiдключився', 'Агент'],
ResponseText = ['<BODY CLASS="MainBody">\n',
	'<H3 CLASS="H3Text">', Html.Title, '</H3>\n',
	'<TABLE CLASS="InfoTable">\n',
	Html.GetHeadRow(Header)
];

for (var i=0; !rs.EOF; i++) {
	var url = ['<A HREF="edituser.asp?UserId=', rs.Fields("Id"), '">', rs.Fields("LoginId"), '</A>'],
	row = ['<TR>', Tag.Write("TD", -1, url.join("")),
		Tag.Write("TD", -1, User.Role[rs.Fields("RoleId")]),
		Tag.Write("TD", 1, rs.Fields("UserIP")),
		Tag.Write("TD", -1, rs.Fields("LastLogin")),
		Tag.Write("TD", -1, rs.Fields("UserAgent"), '</TR>\n')
	];
	ResponseText.push(row.join(""));
	rs.MoveNext();
}
rs.Close();
Connect.Close();
ResponseText.push(Html.GetFooterRow(5, i));
Response.Write(ResponseText.join(""))%>