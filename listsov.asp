<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = Session("RoleId") > 0 && Session("RoleId") < 3;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
    var ReportMonth = String(Form("ReportMonth")),
	Filter      = Form("Filter") == "on";
}

try {
	Solaren.SetCmd("ListSov");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("ReportMonth", adVarChar, adParamInput, 10, ReportMonth));
			Append(CreateParameter("Filter", adBoolean, adParamInput, 1, Filter));
		}
	}
	var rs = Solaren.Execute("ListSov", "Iнформацiю не знайдено");
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

Html.SetHead("Баланс");

var Period = Month.GetPeriod(ReportMonth, 0),
tot_s = tot_PurVol = tot_ob_dt = tot_ob_ct = tot_s_end = 0,
ResponseText = '<BODY CLASS="PrnBody">\n' +
'<H3 CLASS="H3PrnTable">Баланс</H3><SPAN CLASS="H3PrnTable">перiод: ' + Period + '</SPAN>\n' +
'<TABLE CLASS="PrnTable">\n' +
'<TR><TH>Споживач</TH><TH>Рахунок</TH><TH>Сальдо<BR>на початок</TH><TH>Обсяг<BR>кВт&#183;год</TH><TH>Вартiсть</TH><TH>Оплата</TH><TH>Сальдо<BR>на кiнець</TH></TR>\n';
	
for (var i=0; !rs.EOF; i++) {
	ResponseText += '<TR><TD>' + rs.Fields("CustomerName") +
	Html.Write("TD","RIGHT") + rs.Fields("ContractPAN") +
	Html.Write("TD","RIGHT") + rs.Fields("s").value.toDelimited(2) +
	Html.Write("TD","RIGHT") + rs.Fields("PurVol").value.toDelimited(0) +
	Html.Write("TD","RIGHT") + rs.Fields("ob_dt").value.toDelimited(2) +
	Html.Write("TD","RIGHT") + rs.Fields("ob_ct").value.toDelimited(2) +
	Html.Write("TD","RIGHT") + rs.Fields("s_end").value.toDelimited(2) + '</TD></TR>\n';
	tot_s      += rs.Fields("s").value;
	tot_PurVol += rs.Fields("PurVol").value;
	tot_ob_dt  += rs.Fields("ob_dt").value;
	tot_ob_ct  += rs.Fields("ob_ct").value;
	tot_s_end  += rs.Fields("s_end").value;
	rs.MoveNext()
} rs.Close();
Connect.Close();
ResponseText += '<TR><TH ALIGN="LEFT" COLSPAN="2">Всього: ' + i +
Html.Write("TH","RIGHT") + tot_s.toDelimited(2) +
Html.Write("TH","RIGHT") + tot_PurVol.toDelimited(0) +
Html.Write("TH","RIGHT") + tot_ob_dt.toDelimited(2) +
Html.Write("TH","RIGHT") + tot_ob_ct.toDelimited(2) +
Html.Write("TH","RIGHT") + tot_s_end.toDelimited(2) + '</TH></TR>\n</TABLE></BODY></HTML>';
Response.Write(ResponseText)%>