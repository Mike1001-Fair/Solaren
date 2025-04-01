<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1;
User.ValidateAccess(Authorized, "POST");

with (Request) {
    var OperatorId   = Form("OperatorId"),
	OperatorName = Form("OperatorName"),
	BegMonth     = String(Form("BegMonth")),
	EndMonth     = String(Form("EndMonth"));
}

try {
	Solaren.SetCmd("ListBalance");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("BegMonth", adVarChar, adParamInput, 10, BegMonth));
			Append(CreateParameter("EndMonth", adVarChar, adParamInput, 10, EndMonth));
			Append(CreateParameter("OperatorId", adVarChar, adParamInput, 10, OperatorId));
		}
	}
	var rs = Solaren.Execute("ListBalance");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetHead("Баланс", 0);
}

var Period = [Month.GetPeriod(BegMonth, 0)],
FinalMonth = Month.GetPeriod(EndMonth, 0),
totRetVol = totPurVol = totNeedVol = 0;

if (BegMonth != EndMonth) {
	Period.push(FinalMonth);
}

var Header = ['РЕМ', 'Видача', 'Покупка', 'Потреби'],
ResponseText = ['<BODY CLASS="PrnBody">',
	'<H3 CLASS="H3PrnTable">Баланс</H3><SPAN CLASS="H3PrnTable">перiод: ' + Period.join(' &ndash; ') + '</SPAN>',
	'<TABLE CLASS="PrnTable">',
	'<CAPTION>оператор: ' + OperatorName + '</CAPTION>',
	Html.GetHeadRow(Header)
]

for (var i=0; !rs.EOF; i++) {
	var row = ['<TR>', Tag.Write("TD", -1, rs.Fields("AenName")),
		Tag.Write("TD", 2, rs.Fields("RetVol").value.toDelimited(0)),
		Tag.Write("TD", 2, rs.Fields("PurVol").value.toDelimited(0)),
		Tag.Write("TD", 2, rs.Fields("NeedVol").value.toDelimited(0)), '</TR>'
	];
	ResponseText.push(row.join(""));
	totRetVol += rs.Fields("RetVol");
	totPurVol += rs.Fields("PurVol");
	totNeedVol += rs.Fields("NeedVol");
	rs.MoveNext();
}
rs.Close();
Solaren.Close();

var footer = [
	'<TR><TH ALIGN="LEFT">Всього: ', i, '</TH>',
	Tag.Write("TH", 2, totRetVol.toDelimited(0)),
	Tag.Write("TH", 2, totPurVol.toDelimited(0)),
	Tag.Write("TH", 2, totNeedVol.toDelimited(0)),
	'</TR>\n</TABLE></BODY></HTML>'
];
ResponseText.push(footer.join(""));
Response.Write(ResponseText.join("\n"))%>