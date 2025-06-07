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
    var BegMonth = String(Form("BegMonth")),
	EndMonth = String(Form("EndMonth"));
}

try {
	Solaren.SetCmd("ListVolRem");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("BegMonth", adVarChar, adParamInput, 10, BegMonth));
			Append(CreateParameter("EndMonth", adVarChar, adParamInput, 10, EndMonth));
		}
	}
	var rs = Solaren.Execute("ListVolRem");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetHead("Звiт", 0);
}

var Range = Month.GetRange(BegMonth, EndMonth),
totVol = totVolCost = totPdfo = totVz = totPurCost = 0,
Header = ['кВт&#183;год', 'Вартiсть', 'ПДФО', 'ВЗ', 'До сплати'],
ResponseText = ['<BODY CLASS="PrnBody">',
	'<H3 CLASS="H3PrnTable">Вартiсть купiвлi електричної енергiї</H3><SPAN CLASS="H3PrnTable">перiод: ' + Range + '</SPAN>',
	'<TABLE CLASS="PrnTable">',
	'<TR><TH ROWSPAN="2">ЦОС</TH><TH>Обсяг</TH><TH COLSPAN="4">грн</TH></TR>',
	Html.GetHeadRow(Header)
];

for (var i=0; !rs.EOF; i++) {
	var row = ['<TR>', Tag.Write("TD", -1, rs.Fields("BranchName")),
		Tag.Write("TD", 2, rs.Fields("Vol").value.toDelimited(0)),
		Tag.Write("TD", 2, rs.Fields("VolCost").value.toDelimited(2)),
		Tag.Write("TD", 2, rs.Fields("Pdfo").value.toDelimited(2)),
		Tag.Write("TD", 2, rs.Fields("Vz").value.toDelimited(2)),
		Tag.Write("TD", 2, rs.Fields("PurCost").value.toDelimited(2)), '</TR>'
	]
	ResponseText.push(row.join(""));
	totVol     += rs.Fields("Vol");
	totVolCost += rs.Fields("VolCost");
	totPdfo    += rs.Fields("Pdfo");
	totVz      += rs.Fields("Vz");
	totPurCost += rs.Fields("PurCost");
	rs.MoveNext();
}
rs.Close();
Solaren.Close();

var footer = ['<TR><TH ALIGN="LEFT">Всього: ', i, '</TH>',
	Tag.Write("TH", 2, totVol.toDelimited(0)),
	Tag.Write("TH", 2, totVolCost.toDelimited(2)),
	Tag.Write("TH", 2, totPdfo.toDelimited(2)),
	Tag.Write("TH", 2, totVz.toDelimited(2)),
	Tag.Write("TH", 2, totPurCost.toDelimited(2)),
	'</TR>\n</TABLE></BODY></HTML>'
];
ResponseText.push(footer.join(""));
Response.Write(ResponseText.join("\n"))%>


