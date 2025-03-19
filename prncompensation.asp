<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1;
User.ValidateAccess(Authorized, "POST");

with (Request) {
	var ReportMonth = String(Form("ReportMonth")),
	AveragePrice    = String(Form("AveragePrice")),
	ChiefId         = Form("ChiefId");
}

try {
	Solaren.SetCmd("ListCompensation");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adInteger, adParamInput, 10, User.Id));
			Append(CreateParameter("ReportMonth", adVarChar, adParamInput, 10, ReportMonth));
		}
	}
	var rs = Solaren.Execute("ListCompensation");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetHead("Компенсація");
}

var Period = Month.GetPeriod(ReportMonth, 0),
Compensation = totRetVol = totRecVol = totPurVol = totCompensation = 0,
Caption = ['Середньозважена ціна: ', AveragePrice.replace(".", ","), ' коп.'],
Header   = ['З', 'По', 'коп', 'Видача', 'Потреби', 'Покупка', '&#8372;'],
ResponseText = ['\n<BODY CLASS="PrnBody">',
		'<H3 CLASS="H3PrnTable">Компенсація</H3><SPAN CLASS="H3PrnTable">перiод: ' + Period + '</SPAN>',
		'<TABLE CLASS="PrnTable">',
		Tag.Write("CAPTION", -1, Caption.join("")),
		'<TR><TH ROWSPAN="2">Рахунок</TH><TH COLSPAN="2">Період</TH><TH ROWSPAN="2">Споживач</TH><TH ROWSPAN="2">EIC</TH><TH>Тариф</TH>	<TH COLSPAN="3">кВт&#183;год</TH><TH>Компенсація</TH></TR>',
		Html.GetHeadRow(Header)
];

for (var i=0; !rs.EOF; i++) {
	Compensation = Math.round(rs.Fields("PurVol") * (rs.Fields("Tarif") - AveragePrice))/100;
	var row = ['<TR>', Tag.Write("TD", 2, rs.Fields("ContractPAN")),
		Tag.Write("TD", -1, rs.Fields("BegDate")),
		Tag.Write("TD", -1, rs.Fields("EndDate")),
		Tag.Write("TD", -1, rs.Fields("CustomerName")),
		Tag.Write("TD", -1, rs.Fields("EICode")),

		Tag.Write("TD", 2, rs.Fields("Tarif").value.toDelimited(2)),
		Tag.Write("TD", 2, rs.Fields("RetVol").value.toDelimited(0)),
		Tag.Write("TD", 2, rs.Fields("RecVol").value.toDelimited(0)),
		Tag.Write("TD", 2, rs.Fields("PurVol").value.toDelimited(0)),
		Tag.Write("TD", 2, Compensation.toDelimited(2)), '</TR>'
	];
	ResponseText.push(row.join(""));
	totRetVol += rs.Fields("RetVol");
	totRecVol += rs.Fields("RecVol");
	totPurVol += rs.Fields("PurVol");
	totCompensation += Compensation;
	rs.MoveNext();
}
rs.Close();
Solaren.Close();

var footer = ['<TR><TH ALIGN="LEFT" COLSPAN="6">Всього: ' + i,
	Tag.Write("TH", 2, totRetVol.toDelimited(0)),
	Tag.Write("TH", 2, totRecVol.toDelimited(0)),
	Tag.Write("TH", 2, totPurVol.toDelimited(0)),
	Tag.Write("TH", 2, totCompensation.toDelimited(2)),
	'</TR>\n</TABLE></BODY></HTML>'
];
ResponseText.push(footer.join(""));
Response.Write(ResponseText.join("\n"))%>
