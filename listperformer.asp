<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") >= 0 || Session("RoleId") < 2;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
	var PerformerName = Form("PerformerName"),
	Deleted           = Form("Deleted") == "on";
}

try {
	Solaren.SetCmd("ListPerformer");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("PerformerName", adVarChar, adParamInput, 10, PerformerName));
			Append(CreateParameter("Deleted", adBoolean, adParamInput, 1, Deleted));
		}
	}
	var rs = Solaren.Execute("ListPerformer", "Iнформацiю не знайдено");
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

with (Html) {
	SetHead("Виконавці");
	WriteScript();
	Menu.Write(Session("RoleId"), 0);
}

Response.Write('<BODY CLASS="MainBody">\n' +
	'<H3 CLASS="H3Text">Список виконавців</H3>\n' +
	'<TABLE CLASS="InfoTable">\n' + 
	'<TR><TH>Логін</TH><TH>ПIБ</TH><TH>Телефон</TH><TH>ЦОС</TH></TR>\n');
for (var i=0; !rs.EOF; i++) {
	Response.Write('<TR><TD><A href="editperformer.asp?PerformerId=' + rs.Fields("Id") + '">' + rs.Fields("LoginId") + '</A></TD>' + 
	Html.Write("TD","") + rs.Fields("UserName") + 
	Html.Write("TD","") + rs.Fields("Phone") +
	Html.Write("TD","") + rs.Fields("BranchName") + '</TD></TR>\n');
	rs.MoveNext();
} rs.Close();Connect.Close();
Response.Write('<TR><TH ALIGN="LEFT" COLSPAN="4">Всього: ' + i + '</TH></TR>\n</TABLE></BODY></HTML>');
%>