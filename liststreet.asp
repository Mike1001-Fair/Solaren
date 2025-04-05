<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/street.inc" -->
<% var Authorized = Session("RoleId") < 2;
if (!Authorized) Message.Write(2, "Помилка авторизації");

with (Request) {
	var StreetId = Form("StreetId"),
	Deleted      = Form("Deleted") == "on";	
}

try {
	Solaren.SetCmd("ListStreet");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("StreetId", adInteger, adParamInput, 10, StreetId));
			Append(CreateParameter("Deleted", adBoolean, adParamInput, 1, Deleted));
		}
	}
	var rs = Cmd.Execute();
	Solaren.EOF(rs, 'Iнформацiю не знайдено');
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}

with (Html) {
	SetHead("Список вулиць");
	Menu.Write(Session("RoleId"), 0);
}
Response.Write('<BODY CLASS="MainBody">\n' +
	'<H3 CLASS="H3Text">Список ЦОС</H3>\n' +
	'<TABLE CLASS="InfoTable">\n' +
	'<TR><TH>Тип</TH><TH>Назва</TH></TR>\n');
for (var i=0; !rs.EOF; i++) {
	Response.Write('<TR><TD>' + Street.Type[rs.Fields("StreetType")] + 
	Html.Write("TD","") + '<A href="editstreet.asp?StreetId=' + rs.Fields("Id") + '">' + rs.Fields("StreetName") + '</A></TD></TR>\n');
	rs.MoveNext();
} rs.Close(); Solaren.Close();
Response.Write('<TR><TH ALIGN="LEFT" COLSPAN="2">Всього: ' + i + '</TH></TR>\n</TABLE></BODY></HTML>')%>

