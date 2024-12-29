<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->

<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
    var BegDate = String(Form("BegDate")),
	EndDate = String(Form("EndDate"));
}

try {
	Solaren.SetCmd("ListSalesReport");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("BegDate", adVarChar, adParamInput, 10, BegDate));
			Append(CreateParameter("EndDate", adVarChar, adParamInput, 10, EndDate));
		}
	}
	var rs = Cmd.Execute();
	Solaren.EOF(rs, 'Iнформацiю не знайдено');
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

var Period = BegDate.formatDate("-"),
EndDate    = EndDate.formatDate("-"),
totalQuantity = 0;

if (Period != EndDate) Period += ' &ndash; ' + EndDate;

var ResponseText = '<BODY CLASS="MainBody">\n' +
	'<H3 CLASS="H3Text">Звіт<SPAN>Період: ' + Period + '</SPAN></H3>\n' +
	'<TABLE CLASS="InfoTable">\n' + 
	'<TR><TH>Назва</TH><TH>Кількість</TH></TR>\n';

with (Html) {
	SetHead("Звіт");
	Menu.Write(Session("RoleId"), 0);
}

for (var i=0; !rs.EOF; i++) {
	ResponseText += '<TR><TD>' + rs.Fields("ItemName") +
	Html.Write("TD","RIGHT") + rs.Fields("Quantity") + '</TD></TR>\n';
	totalQuantity += rs.Fields("Quantity").value;
	rs.MoveNext();
} rs.Close();Connect.Close();
ResponseText += '<TR><TH ALIGN="LEFT">Всього: ' + i + 
Html.Write("TH","RIGHT") + totalQuantity.toDelimited(0) + '</TH></TR>\n</TABLE></BODY></HTML>';
Response.Write(ResponseText)%>