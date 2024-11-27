<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = Session("RoleId") == 0,
Title = "Користувачi";

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
	var LoginId = Form("LoginId"),
	RoleId      = Form("RoleId"),
	ConnectDate = Form("ConnectDate");
}

try {
	Solaren.SetCmd("ListUsers");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("LoginId", adVarChar, adParamInput, 20, LoginId));
			Append(CreateParameter("RoleId", adVarChar, adParamInput, 10, RoleId));
			Append(CreateParameter("SessionId", adInteger, adParamInput, 10, Session.SessionID));
			Append(CreateParameter("ConnectDate", adVarChar, adParamInput, 20, ConnectDate));
		}
	}
	var rs = Cmd.Execute();
	Solaren.EOF(rs, 'Iнформацiю не знайдено');
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

with (Html) {
	SetHead(Title);
	WriteScript();
	WriteMenu(Session("RoleId"));
}

var ResponseText = '<BODY CLASS="MainBody">\n' +
	'<H3 CLASS="H3Text">' + Title + '</H3>\n' +
	'<TABLE CLASS="InfoTable">\n' +
	'<TR><TH>Логiн</TH><TH>Роль</TH><TH>Ip</TH><TH>Пiдключився</TH><TH>Агент</TH></TR>\n';

for (var i=0; !rs.EOF; i++) {
	ResponseText += '<TR ALIGN="LEFT"><TD><A HREF="edituser.asp?UserId=' + rs.Fields("Id") + '">' + rs.Fields("LoginId") + '</A></TD>' +
	Html.Write("TD","") + User.Role[rs.Fields("RoleId")] +
	Html.Write("TD","CENTER") + rs.Fields("UserIP") +
	Html.Write("TD","") + rs.Fields("LastLogin") +
	Html.Write("TD","") + rs.Fields("UserAgent") + '</TD></TR>\n';
	rs.MoveNext();
} rs.Close();Connect.Close();

ResponseText += Html.GetFooterRow(5, i);
Response.Write(ResponseText)%>
