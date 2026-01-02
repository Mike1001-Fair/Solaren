<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/list.set" -->
<% var Authorized = Session("RoleId") == 1,
CustomerId = Request.Form("CustomerId");

if (!Authorized) Message.Write(2, "Помилка авторизації");

try {
	Solaren.SetCmd("ListCustomer");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("CustomerId", adInteger, adParamInput, 10, CustomerId));
		}
	}
	var rs = Cmd.Execute();
	Solaren.EOF(rs, 'Iнформацiю не знайдено');
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}

with (Html) {
	SetHead("Список споживачiв");
	Menu.Write(Session("RoleId"), 0);
}

Response.Write('<BODY CLASS="MainBody" ONLOAD="Loader.SetClick(`td > a`)">\n' +
	'<H3 CLASS="H3Text">Список споживачiв</H3>\n' +
	'<TABLE CLASS="InfoTable">\n' +
	'<TR><TH>РНОКПП</TH><TH>Споживач</TH><TH>Телефон</TH></TR>\n');
for (var i=0; !rs.EOF; i++) {
	Response.Write('<TR><TD>' + rs.Fields("Code") +
	Html.Write("TD","LEFT") + '<A href="editcustomer.asp?CustomerId=' + rs.Fields("Id") + '">' + rs.Fields("CustomerName") + '</A>' +
	Html.Write("TD","") + rs.Fields("Phone") + '</TD></TR>\n');
	rs.MoveNext();
} rs.Close(); Solaren.Close();
Response.Write('<TR><TH ALIGN="LEFT" COLSPAN="3">Всього: ' + i + '</TH></TR>\n</TABLE></BODY></HTML>')%>


