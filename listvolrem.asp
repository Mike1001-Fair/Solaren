<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE VIRTUAL="Solaren/Set/list.set" -->
<% var Authorized = User.RoleId == 1;
User.CheckAccess(Authorized, "POST");

with (Request) {
    var BegMonth = String(Form("BegMonth")),
	EndMonth = String(Form("EndMonth"));
}

try {
	Db.SetCmd("ListVolRem");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("BegMonth", adVarChar, adParamInput, 10, BegMonth));
			Append(CreateParameter("EndMonth", adVarChar, adParamInput, 10, EndMonth));
		}
	}
	var rs = Db.Execute("ListVolRem");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetHead("Звiт", 0);
}

var Range = Month.GetRange(BegMonth, EndMonth),
totVol = totVolCost = totPdfo = totVz = totPurCost = 0,
Header = ['кВт&#183;год', 'Вартiсть', 'ПДФО', 'ВЗ', 'До сплати'],
Output = ['<BODY CLASS="PrnBody">',
	'<H3 CLASS="H3PrnTable">Вартiсть купiвлi електричної енергiї</H3><SPAN CLASS="H3PrnTable">перiод: ' + Range + '</SPAN>',
	'<TABLE CLASS="PrnTable">',
	'<TR><TH ROWSPAN="2">ЦОС</TH><TH>Обсяг</TH><TH COLSPAN="4">грн</TH></TR>',
	Html.GetHeadRow(Header)
];

for (var i=0; !rs.EOF; i++) {
	var row = ['<TR>', Tag.Write("TD", -1, rs.Fields("BranchName")),
		Tag.Write("TD", 2, rs.Fields("Vol").Value.toDelimited(0)),
		Tag.Write("TD", 2, rs.Fields("VolCost").Value.toDelimited(2)),
		Tag.Write("TD", 2, rs.Fields("Pdfo").Value.toDelimited(2)),
		Tag.Write("TD", 2, rs.Fields("Vz").Value.toDelimited(2)),
		Tag.Write("TD", 2, rs.Fields("PurCost").Value.toDelimited(2)), '</TR>'
	]
	Output.push(row.join(""));
	totVol     += rs.Fields("Vol");
	totVolCost += rs.Fields("VolCost");
	totPdfo    += rs.Fields("Pdfo");
	totVz      += rs.Fields("Vz");
	totPurCost += rs.Fields("PurCost");
	rs.MoveNext();
}
rs.Close();
Db.Close();

var footer = ['<TR><TH ALIGN="LEFT">Всього: ', i, '</TH>',
	Tag.Write("TH", 2, totVol.toDelimited(0)),
	Tag.Write("TH", 2, totVolCost.toDelimited(2)),
	Tag.Write("TH", 2, totPdfo.toDelimited(2)),
	Tag.Write("TH", 2, totVz.toDelimited(2)),
	Tag.Write("TH", 2, totPurCost.toDelimited(2)),
	'</TR>\n</TABLE></BODY></HTML>'
];
Output.push(footer.join(""));
Response.Write(Output.join("\n"))%>


