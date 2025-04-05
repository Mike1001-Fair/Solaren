<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2,
BegDate = Request.Form("BegDate");

if (!Authorized) Message.Write(2, "Помилка авторизації");
try {
	Solaren.SetCmd("ListPdfo");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("BegDate", adVarChar, adParamInput, 10, BegDate));
		}
	}
	var rs = Cmd.Execute();
	Solaren.EOF(rs, 'Iнформацiю не знайдено');
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}

with (Html) {
	SetHead("Ставка ПДФО");
	Menu.Write(Session("RoleId"), 0);
}

var ResponseText = '<BODY CLASS="MainBody">\n' +
	'<H3 CLASS="H3Text">Ставка ПДФО</H3>\n' +
	'<TABLE CLASS="InfoTable">\n' +
	'<TR><TH>Дiє з</TH><TH>по</TH><TH>Ставка</TH></TR>\n';

for (var i=0, pdfotax; !rs.EOF; i++) {	
	ResponseText += '<TR><TD ALIGN="CENTER">' + rs.Fields("BegDate") +
	Html.Write("TD","") + rs.Fields("EndDate") +
	Html.Write("TD","RIGHT") + '<A HREF="editpdfo.asp?PdfoId=' + rs.Fields("Id") + '">' + rs.Fields("PdfoTax") + '</A></TD></TR>\n';
	rs.MoveNext();
} rs.Close();Solaren.Close();
ResponseText += Html.GetFooterRow(3, i);
Response.Write(ResponseText)%>

