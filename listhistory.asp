<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1;
User.CheckAccess(Authorized, "POST");

with (Request) {
	var ContractId = Form("ContractId"),
	BegMonth       = String(Form("BegMonth")),
	EndMonth       = String(Form("EndMonth")),
	ContractName   = Form("ContractName");
}

try {
	Solaren.SetCmd("ListHistory");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("ContractId", adVarChar, adParamInput, 10, ContractId));
			Append(CreateParameter("BegMonth", adVarChar, adParamInput, 10, BegMonth));
			Append(CreateParameter("EndMonth", adVarChar, adParamInput, 10, EndMonth));
		}
	}
	var rs = Solaren.Execute("ListHistory");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetHead("Iсторiя розрахункiв")
}

var Header = ['Перiод', 'Сальдо', 'Обсяг', 'Вартiсть', 'Оплата'],
ResponseText = ['<BODY CLASS="PrnBody">',
	'<H3 CLASS="H3PrnTable">Iсторiя розрахункiв</H3><SPAN CLASS="H3PrnTable">' + ContractName + '</SPAN>',
	'<TABLE CLASS="PrnTable">',
	Html.GetHeadRow(Header)
],
totPurVol = totObDt = totObCt = 0;

for (var i=0; !rs.EOF; i++) {
	var row = ['<TR>', Tag.Write("TD", -1, rs.Fields("ReportPeriod")),
		Tag.Write("TD", 2, rs.Fields("s").Value.toDelimited(2)),
		Tag.Write("TD", 2, rs.Fields("PurVol").Value.toDelimited(0)),
		Tag.Write("TD", 2, rs.Fields("ob_dt").Value.toDelimited(2)),
		Tag.Write("TD", 2, rs.Fields("ob_ct").Value.toDelimited(2)), '</TR>'
	]
	ResponseText.push(row.join(""));
	totPurVol += rs.Fields("PurVol");
	totObDt   += rs.Fields("ob_dt");
	totObCt   += rs.Fields("ob_ct");
	rs.MoveNext();
}
rs.Close();
Solaren.Close();

var footer = ['<TR><TH ALIGN="LEFT" COLSPAN="2">Всього: ', i, '</TH>',
	Tag.Write("TH", 2, totPurVol.toDelimited(0)),
	Tag.Write("TH", 2, totObDt.toDelimited(2)),
	Tag.Write("TH", 2, totObCt.toDelimited(2)),
	'</TH></TR>\n</TABLE></BODY></HTML>'
];

ResponseText.push(footer.join(""));
Response.Write(ResponseText.join("\n"))%>


