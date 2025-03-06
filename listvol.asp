<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->

<% var Authorized = Session("RoleId") == 1,
Title = "Обсяги";
if (!Authorized) Message.Write(2, "Помилка авторизації");

with (Request) {
    var ContractId   = Form("ContractId"),
	BegMonth     = String(Form("BegMonth")),
	EndMonth     = String(Form("EndMonth")),
	ContractName = Form("ContractName");
}

try {
	Solaren.SetCmd("ListVol");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("ContractId", adVarChar, adParamInput, 10, ContractId));
			Append(CreateParameter("BegMonth", adVarChar, adParamInput, 10, BegMonth));
			Append(CreateParameter("EndMonth", adVarChar, adParamInput, 10, EndMonth));
		}
	}
	var rs = Solaren.Execute("ListVol", "Iнформацiю не знайдено");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}

with (Html) {
	SetHead(Title);
	WriteScript();
	Menu.Write(Session("RoleId"), 0);
}

var nVol = totRetVol = totRecVol = totSaldo = totnVol = 0,
ResponseText = '<BODY CLASS="MainBody">\n' +
'<H3 CLASS="H3Text">' + Title + '<SPAN>Договор: ' + ContractName + '</SPAN></H3>\n' +
'<TABLE CLASS="InfoTable">\n' +
'<TR><TH>З</TH><TH>По</TH><TH>Прийом</TH><TH>Видача</TH><TH>Покупка</TH><TH>Потреби</TH></TR>\n';

for (var i=0; !rs.EOF; i++) {
	nVol = rs.Fields("RetVol") - rs.Fields("PurVol");
	ResponseText += '<TR><TD><A href="editfactvol.asp?FactVolId=' + rs.Fields("Id") + '">' + rs.Fields("BegDate") + '</A>' + 
	Html.Write("TD","") + rs.Fields("EndDate") +
	Html.Write("TD","RIGHT") + rs.Fields("RecVol").value.toDelimited(0) +
	Html.Write("TD","RIGHT") + rs.Fields("RetVol").value.toDelimited(0) +
	Html.Write("TD","RIGHT") + rs.Fields("PurVol").value.toDelimited(0) +
	Html.Write("TD","RIGHT") + nVol.toDelimited(0) + '</TD></TR>';
	totRecVol += rs.Fields("RecVol");
	totRetVol += rs.Fields("RetVol");
	totSaldo  += rs.Fields("PurVol");
	totnVol   += nVol;
	rs.MoveNext();
} rs.Close();
Connect.Close();

ResponseText += '<TR><TH ALIGN="LEFT" COLSPAN="2">Всього: ' + i +
Html.Write("TH","RIGHT") + totRecVol.toDelimited(0) +
Html.Write("TH","RIGHT") + totRetVol.toDelimited(0) +
Html.Write("TH","RIGHT") + totSaldo.toDelimited(0) +
Html.Write("TH","RIGHT") + totnVol.toDelimited(0) + '</TH></TR>\n</TABLE></BODY></HTML>';
Response.Write(ResponseText)%>
