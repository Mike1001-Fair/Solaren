<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1;
User.ValidateAccess(Authorized, "POST");

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
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Виконавці", User.RoleId);
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
} rs.Close();Solaren.Close();
Response.Write('<TR><TH ALIGN="LEFT" COLSPAN="4">Всього: ' + i + '</TH></TR>\n</TABLE></BODY></HTML>');
%>
