<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 0,
Title = "Користувачi";

Solaren.ValidateMethod("POST", 4);
User.ValidateAccess(Authorized);

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
}

Html.SetPage(Title, User.RoleId);

var ResponseText = ['<BODY CLASS="MainBody">\n' +
	'<H3 CLASS="H3Text">' + Title + '</H3>\n' +
	'<TABLE CLASS="InfoTable">\n' +
	'<TR><TH>Логiн</TH><TH>Роль</TH><TH>Ip</TH><TH>Пiдключився</TH><TH>Агент</TH></TR>\n'
];

for (var i=0; !rs.EOF; i++) {
	ResponseText.push('<TR ALIGN="LEFT"><TD><A HREF="edituser.asp?UserId=' + rs.Fields("Id") + '">' + rs.Fields("LoginId") + '</A></TD>' +
		Html.Write("TD","") + User.Role[rs.Fields("RoleId")] +
		Html.Write("TD","CENTER") + rs.Fields("UserIP") +
		Html.Write("TD","") + rs.Fields("LastLogin") +
		Html.Write("TD","") + rs.Fields("UserAgent") + '</TD></TR>\n');
	rs.MoveNext();
} rs.Close();Connect.Close();

ResponseText.push(Html.GetFooterRow(5, i));
Response.Write(ResponseText.join(""))%>
