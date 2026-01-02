<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE VIRTUAL="Solaren/Set/list.set" -->
<% var Authorized = User.RoleId > 0 && User.RoleId < 3;
User.CheckAccess(Authorized, "POST");

with (Request) {
	var ContractId = Form("ContractId"),
	BegMonth       = String(Form("BegMonth")),
	EndMonth       = String(Form("EndMonth"));
}

try {
	Solaren.SetCmd("ListTotVolCost");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("BegMonth", adVarChar, adParamInput, 10, BegMonth));
			Append(CreateParameter("EndMonth", adVarChar, adParamInput, 10, EndMonth));
			Append(CreateParameter("ContractId", adVarChar, adParamInput, 10, ContractId));
		}
	}
	var rs = Solaren.Execute("ListTotVolCost");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetHead("Звiт", 0);
}

var Range = Month.GetRange(BegMonth, EndMonth),
totVol = totVolCost = totPdfo = totVz = totPurCost = 0,
Header = ['кВт&#183;год', 'Вартiсть', 'ПДФО', 'ВЗ', 'До сплати'],
Output = ['<BODY CLASS="PrnBody">',
	'<H3 CLASS="H3PrnTable">Вартiсть купiвлi електричної енергiї<SPAN>перiод: ' + Range + '</SPAN></H3>',
	'<TABLE CLASS="PrnTable">',
	'<TR><TH ROWSPAN="2">Рахунок</TH><TH ROWSPAN="2">Споживач</TH><TH>Обсяг</TH><TH COLSPAN="4">&#8372;</TH></TR>',
	Html.GetHeadRow(Header)
];

for (var i=0; !rs.EOF; i++) {
	var td = [Tag.Write("TD", -1, rs.Fields("ContractPAN")),
		Tag.Write("TD", -1,  rs.Fields("CustomerName")),
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

var th = ['<TH ALIGN="LEFT" COLSPAN="2">Всього: ', i, '</TH>',
	Tag.Write("TH", 2, totVol.toDelimited(0)),
	Tag.Write("TH", 2, totVolCost.toDelimited(2)),
	Tag.Write("TH", 2, totPdfo.toDelimited(2)),
	Tag.Write("TH", 2, totVz.toDelimited(2)),
	Tag.Write("TH", 2, totPurCost.toDelimited(2))
],
tr = Tag.Write("TR", -1, th.join(""));
Output.push(tr);
Output.push('</TABLE></BODY></HTML>');
Response.Write(Output.join("\n"))%>
