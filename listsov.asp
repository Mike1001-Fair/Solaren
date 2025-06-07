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
    var ReportMonth = String(Form("ReportMonth")),
	Filter = Form("Filter") == "on";
}

try {
	Solaren.SetCmd("ListSov");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("ReportMonth", adVarChar, adParamInput, 10, ReportMonth));
			Append(CreateParameter("Filter", adBoolean, adParamInput, 1, Filter));
		}
	}
	var rs = Solaren.Execute("ListSov");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetHead("Баланс");
}

var Header = ["Споживач", "Рахунок", "Сальдо<BR>на початок", "Обсяг<BR>кВт&#183;год", "Вартiсть", "Оплата", "Сальдо<BR>на кiнець"],
Period = Month.GetPeriod(ReportMonth, 0),
tot_s = tot_PurVol = tot_ob_dt = tot_ob_ct = tot_s_end = 0,
ResponseText = ['<BODY CLASS="PrnBody">',
	'<H3 CLASS="H3PrnTable">' + Html.Title + '</H3>',
	'<SPAN CLASS="H3PrnTable">перiод: ' + Period + '</SPAN>',
	'<TABLE CLASS="PrnTable">',
	Html.GetHeadRow(Header)
];
	
for (var i=0; !rs.EOF; i++) {
	var row = ['<TR>', Tag.Write("TD", -1, rs.Fields("CustomerName")),
		Tag.Write("TD", 2, rs.Fields("ContractPAN")),
		Tag.Write("TD", 2, rs.Fields("s").value.toDelimited(2)),
		Tag.Write("TD", 2, rs.Fields("PurVol").value.toDelimited(0)),
		Tag.Write("TD", 2, rs.Fields("ob_dt").value.toDelimited(2)),
		Tag.Write("TD", 2, rs.Fields("ob_ct").value.toDelimited(2)),
		Tag.Write("TD", 2, rs.Fields("s_end").value.toDelimited(2)), '</TR>'
	];
	ResponseText.push(row.join(""));
	tot_s      += rs.Fields("s").value;
	tot_PurVol += rs.Fields("PurVol").value;
	tot_ob_dt  += rs.Fields("ob_dt").value;
	tot_ob_ct  += rs.Fields("ob_ct").value;
	tot_s_end  += rs.Fields("s_end").value;
	rs.MoveNext()
}
rs.Close();
Solaren.Close();
var footer = ['<TR><TH ALIGN="LEFT" COLSPAN="2">Всього: ', i, '</TH>',
	Tag.Write("TH", 2, tot_s.toDelimited(2)),
	Tag.Write("TH", 2, tot_PurVol.toDelimited(0)),
	Tag.Write("TH", 2, tot_ob_dt.toDelimited(2)),
	Tag.Write("TH", 2, tot_ob_ct.toDelimited(2)),
	Tag.Write("TH", 2, tot_s_end.toDelimited(2)),
	'</TR>\n</TABLE></BODY></HTML>'
];
ResponseText.push(footer.join(""));
Response.Write(ResponseText.join("\n"))%>
