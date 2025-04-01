<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = User.RoleId == 1;
User.ValidateAccess(Authorized, "POST");

with (Request) {
    var BegMonth = String(Form("BegMonth")),
	EndMonth = String(Form("EndMonth"));
}

try {
	Solaren.SetCmd("ListVolPay");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("BegMonth", adVarChar, adParamInput, 10, BegMonth));
			Append(CreateParameter("EndMonth", adVarChar, adParamInput, 10, EndMonth));
		}
	}
	var rs = Solaren.Execute("ListVolPay");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetHead("Енергозбереження");
}

var Range = Month.GetRange(BegMonth, EndMonth),
pwr = totRetVol = totPurVol = totPaySum = 0,
Header = ['Споживач', 'Рахунок', 'Адреса', 'Дата', 'Потужнiсть<BR>кВт', 'Видача<BR>кВт&#183;год', 'Покупка<BR>кВт&#183;год', 'Оплата<BR>&#8372;'],
ResponseText = ['<BODY CLASS="PrnBody">',
	'<H3 CLASS="H3PrnTable">' + Html.Title + '</H3>',
	'<SPAN CLASS="H3PrnTable">перiод: ' + Range + '</SPAN>',
	'<TABLE CLASS="PrnTable">',
	Html.GetHeadRow(Header)
];

for (var i=0; !rs.EOF; i++) {
	var row = ['<TR>', Tag.Write("TD", -1, rs.Fields("CustomerName")),
		Tag.Write("TD", -1, rs.Fields("ContractPAN")),
		Tag.Write("TD", -1, rs.Fields("CustomerAddress")),
		Tag.Write("TD", -1, rs.Fields("ContractDate")),
		Tag.Write("TD", 2, rs.Fields("ContractPower").value.toDelimited(2)),
		Tag.Write("TD", 2, rs.Fields("RetVol").value.toDelimited(0)),
		Tag.Write("TD", 2, rs.Fields("PurVol").value.toDelimited(0)),
		Tag.Write("TD", 2, rs.Fields("PaySum").value.toDelimited(2)), '</TR>'
	];
	ResponseText.push(row.join(""));
	pwr += rs.Fields("ContractPower");
	totRetVol += rs.Fields("RetVol");
	totPurVol += rs.Fields("PurVol");
	totPaySum += rs.Fields("PaySum");
	rs.MoveNext();
} rs.Close();Solaren.Close();

var footer = ['<TR><TH ALIGN="LEFT" COLSPAN="4">Всього: ', i, '</TH>',
	Tag.Write("TH", 2, pwr.toDelimited(2)),
	Tag.Write("TH", 2, totRetVol.toDelimited(0)),
	Tag.Write("TH", 2, totPurVol.toDelimited(0)),
	Tag.Write("TH", 2, totPaySum.toDelimited(2)),
	'</TR>\n</TABLE></BODY></HTML>'
];
ResponseText.push(footer.join(""));
Response.Write(ResponseText.join("\n"))%>
