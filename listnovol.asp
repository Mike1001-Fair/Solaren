<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = Session("RoleId") == 1 || Session("RoleId") == 2;
if (!Authorized) Message.Write(2, "Помилка авторизації");

try {
	Solaren.SetCmd("ListNoVol");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("OperDate", adVarChar, adParamInput, 10, Month.Date[1]));
		}
	}
	var rs = Cmd.Execute();
	Solaren.EOF(rs, 'Iнформацiю не знайдено');
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}

with (Html) {
	SetHead("Звіт");
	Menu.Write(Session("RoleId"), 0)
}

var ResponseText = '<BODY CLASS="MainBody">\n' +
	'<H3 CLASS="H3Text">Договора без обсягiв<SPAN>' + Month.GetPeriod(Month.GetMonth(1), 0) + '</SPAN></H3>\n' +
	'<TABLE CLASS="InfoTable">\n' +
	'<TR><TH>Споживач</TH><TH>Рахунок</TH><TH>ЦОС</TH></TR>\n';
for (var i=0; !rs.EOF; i++) {
	ResponseText += '<TR><TD>' + rs.Fields("CustomerName") +
	Html.Write("TD","") + rs.Fields("ContractPAN") +
	Html.Write("TD","") + rs.Fields("BranchName") + '</TD></TR>\n';
	rs.MoveNext();
} rs.Close(); Solaren.Close();
ResponseText += Html.GetFooterRow(3, i);
Response.Write(ResponseText)%>
