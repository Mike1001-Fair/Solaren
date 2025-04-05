<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->

<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Message.Write(2, "Помилка авторизації");

with (Request) {
	var ReportDate = String(Form("ReportDate"));
}

try {
	Solaren.SetCmd("ListContractNumber");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("ReportDate", adVarChar, adParamInput, 10, ReportDate));

		}
	}
	var rs = Cmd.Execute();
	Solaren.EOF(rs, 'Iнформацiю не знайдено');
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}

Html.SetHead("Звiт");
var totContractNumber = totContractPower = 0,
ResponseText = '<BODY CLASS="PrnBody">\n' +
	'<H3 CLASS="H3PrnTable">Кiлькiсть договорiв</H3><SPAN CLASS="H3PrnTable">станом на: ' + ReportDate.formatDate("-") + '</SPAN>\n' +
	'<TABLE CLASS="PrnTable">\n' +
	'<TR><TH>ЦОС</TH><TH>Кiлькiсть</TH></TH><TH>Потужнiсть</TH></TR>\n';

for (var i=0; !rs.EOF; i++) {
	ResponseText += '<TR><TD>' + rs.Fields("BranchName") +
	Html.Write("TD","RIGHT") + rs.Fields("ContractNumber").value.toDelimited(0) +
	Html.Write("TD","RIGHT") + rs.Fields("ContractPower").value.toDelimited(2) + '</TD></TR>\n';
	totContractNumber += rs.Fields("ContractNumber");
	totContractPower += rs.Fields("ContractPower");
	rs.MoveNext();
} rs.Close();Solaren.Close();

ResponseText += '<TR><TH ALIGN="LEFT">Всього: ' + i +
Html.Write("TH","RIGHT") + totContractNumber.toDelimited(0) +
Html.Write("TH","RIGHT") + totContractPower.toDelimited(2) + '</TH></TR>\n</TABLE></BODY></HTML>';
Response.Write(ResponseText)%>

