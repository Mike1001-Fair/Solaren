<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2;
if (!Authorized) Message.Write(2, "Помилка авторизації");

with (Request) {
	var AenName = Form("AenName"),
	Deleted = Form("Deleted") == "on";
}

try {
	Solaren.SetCmd("ListAen");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("AenName", adVarChar, adParamInput, 10, AenName));
			Append(CreateParameter("Deleted", adBoolean, adParamInput, 1, Deleted));
		}
	}
	var rs = Cmd.Execute();
	Solaren.EOF(rs, 'Iнформацiю не знайдено');
	with (Html) {
		SetHead("Список РЕМ");
		Menu.Write(Session("RoleId"), 0);
	}
	Response.Write('<BODY CLASS="MainBody">\n' +
		'<H3 CLASS="H3Text">Список РЕМ</H3>\n' +
		'<TABLE CLASS="InfoTable">\n' +
		'<TR><TH>№</TH><TH>Назва</TH></TR>\n');
	for (var i=0; !rs.EOF; i++) {
		Response.Write('<TR><TD ALIGN="CENTER">' + rs.Fields("SortCode") +
		Html.Write("TD","") + '<A href="editaen.asp?AenId=' + rs.Fields("AenId") + '">' + rs.Fields("AenName") + '</A></TD></TR>\n');
		rs.MoveNext();
	} rs.Close();Connect.Close();
	Response.Write('<TR><TH ALIGN="LEFT" COLSPAN="2">Всього: ' + i + '</TH></TR>\n</TABLE></BODY></HTML>');
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}%>