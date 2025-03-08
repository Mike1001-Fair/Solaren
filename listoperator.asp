<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2,
OperatorName = Request.Form("OperatorName");

if (!Authorized) Message.Write(2, "Помилка авторизації");

try {
	Solaren.SetCmd("ListOperator");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("OperatorName", adVarChar, adParamInput, 10, OperatorName));
		}
	}
	var rs = Cmd.Execute();
	Solaren.EOF(rs, 'Iнформацiю не знайдено');
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}

with (Html) {
	SetHead("Оператори");
	Menu.Write(Session("RoleId"), 0);
}

var ResponseText = '<BODY CLASS="MainBody">\n' +
	'<H3 CLASS="H3Text">Оператори</H3>\n' +
	'<TABLE CLASS="InfoTable">\n' +
	'<TR><TH>№</TH><TH>ЄДРПОУ</TH><TH>Назва</TH></TR>\n';

for (var i=0; !rs.EOF; i++) {
	ResponseText += '<TR><TD ALIGN="CENTER">' + rs.Fields("SortCode") +
	Html.Write("TD","") + rs.Fields("EdrpoCode") +
	Html.Write("TD","LEFT") + '<A href="editoperator.asp?OperatorId=' + rs.Fields("OperatorId") + '">' + rs.Fields("OperatorName") + '</A></TD></TR>\n';
	rs.MoveNext();
} rs.Close(); Solaren.Close();
ResponseText += Html.GetFooterRow(3, i);
Response.Write(ResponseText)%>
