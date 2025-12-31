<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE VIRTUAL="Solaren/Include/list.inc" --><% var Authorized = User.RoleId == 1;
User.CheckAccess(Authorized, "POST");

with (Request) {
	var BranchId = Form("BranchId"),
	BranchName   = Form("BranchName"),
	BegMonth     = String(Form("BegMonth")),
	EndMonth     = String(Form("EndMonth"));
}

try {
	Solaren.SetCmd("ListBranchAct");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("BegMonth", adVarChar, adParamInput, 10, BegMonth));
			Append(CreateParameter("EndMonth", adVarChar, adParamInput, 10, EndMonth));
			Append(CreateParameter("BranchId", adVarChar, adParamInput, 10, BranchId));
		}
	}
	var rs = Solaren.Execute("ListBranchAct");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetHead("Звiт");
}

var Range = Month.GetRange(BegMonth, EndMonth),
totVol = totVolCost = totPdfo = totVz = totPurCost = 0,
Header = ['коп', 'кВт&#183;год', 'Вартiсть', 'ПДФО', 'ВЗ', 'До сплати'],
Output = ['<BODY CLASS="PrnBody">',
	'<H3 CLASS="H3PrnTable">Вартiсть купiвлi електричної енергiї</H3><SPAN CLASS="H3PrnTable">перiод: ' + Range + '</SPAN>',
	'<TABLE CLASS="PrnTable">',
	Tag.Write("CAPTION", -1, BranchName),
	'<TR><TH ROWSPAN="2">З</TH><TH ROWSPAN="2">По</TH><TH ROWSPAN="2">Споживач</TH><TH ROWSPAN="2">Рахунок</TH><TH>Тариф</TH><TH>Обсяг</TH><TH COLSPAN="4">грн</TH></TR>',
	Html.GetHeadRow(Header)
];

for (var i = 0; !rs.EOF; i++) {
	var td = [Tag.Write("TD", -1, rs.Fields("BegDate")),
		Tag.Write("TD", -1, rs.Fields("EndDate")),
		Tag.Write("TD", -1, rs.Fields("CustomerName")),
		Tag.Write("TD", -1, rs.Fields("ContractPAN")),
		Tag.Write("TD", 2, rs.Fields("Tarif").Value.toDelimited(2)),
		Tag.Write("TD", 2, rs.Fields("Vol").Value.toDelimited(0)),
		Tag.Write("TD", 2, rs.Fields("VolCost").Value.toDelimited(2)),
		Tag.Write("TD", 2, rs.Fields("Pdfo").Value.toDelimited(2)),
		Tag.Write("TD", 2, rs.Fields("Vz").Value.toDelimited(2)),
		Tag.Write("TD", 2, rs.Fields("PurCost").Value.toDelimited(2))
	],
	tr = Tag.Write("TR", -1, td.join(""));
	Output.push(tr);
	totVol     += rs.Fields("Vol");
	totVolCost += rs.Fields("VolCost");
	totPdfo    += rs.Fields("Pdfo");
	totVz      += rs.Fields("Vz");
	totPurCost += rs.Fields("PurCost");
	rs.MoveNext();
}
rs.Close();
Solaren.Close();

var footer = ['<TR><TH ALIGN="LEFT" COLSPAN="5">Всього: ', i, '</TH>',
	Tag.Write("TH", 2, totVol.toDelimited(0)),
	Tag.Write("TH", 2, totVolCost.toDelimited(2)),
	Tag.Write("TH", 2, totPdfo.toDelimited(2)),
	Tag.Write("TH", 2, totVz.toDelimited(2)),
	Tag.Write("TH", 2, totPurCost.toDelimited(2)),
	'</TH></TR>\n</TABLE></BODY></HTML>'
];

Output.push(footer.join(""));
Response.Write(Output.join("\n"))%>
