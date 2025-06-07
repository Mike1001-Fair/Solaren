<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId > 0 && User.RoleId < 3;
User.ValidateAccess(Authorized, "POST");

with (Request) {
	var ContractId = Form("ContractId"),
	BegMonth       = String(Form("BegMonth")),
	EndMonth       = String(Form("EndMonth")),
	ContractName   = Form("ContractName");
}

try {
	Solaren.SetCmd("ListVolCost");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("BegMonth", adVarChar, adParamInput, 10, BegMonth));
			Append(CreateParameter("EndMonth", adVarChar, adParamInput, 10, EndMonth));
			Append(CreateParameter("ContractId", adVarChar, adParamInput, 10, ContractId));
		}
	}
	var rs = Solaren.Execute("ListVolCost");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetHead("Звiт", 0);
}

var Range = Month.GetRange(BegMonth, EndMonth),
totVol = totVolCost = totPdfo = totVz = totPurCost = 0,
Header = ['З', 'По', 'коп', 'кВт&#183;год', 'Вартiсть', 'ПДФО', 'ВЗ', 'До сплати'],
ResponseText = ['<BODY CLASS="PrnBody">',
	'<H3 CLASS="H3PrnTable">Вартiсть купiвлi електричної енергiї<SPAN>перiод: ' + Range + '</SPAN></H3>',
	'<TABLE CLASS="PrnTable">',
	Tag.Write("CAPTION", -1, ContractName + ', ' + rs.Fields("EICode")),
	'<TR><TH COLSPAN="2">Період</TH><TH>Тариф</TH><TH>Обсяг</TH><TH COLSPAN="4">&#8372;</TH></TR>',
	Html.GetHeadRow(Header)
];

for (var i=0; !rs.EOF; i++) {
	var td = [Tag.Write("TD", -1, rs.Fields("BegDate")),
		Tag.Write("TD", -1,  rs.Fields("EndDate")),
		Tag.Write("TD", 2, rs.Fields("Tarif").value.toDelimited(2)),
		Tag.Write("TD", 2, rs.Fields("Vol").value.toDelimited(0)),
		Tag.Write("TD", 2, rs.Fields("VolCost").value.toDelimited(2)),
		Tag.Write("TD", 2, rs.Fields("Pdfo").value.toDelimited(2)),
		Tag.Write("TD", 2, rs.Fields("Vz").value.toDelimited(2)),
		Tag.Write("TD", 2, rs.Fields("PurCost").value.toDelimited(2))
	],
	tr = Tag.Write("TR", -1, td.join(""));
	ResponseText.push(tr);
	totVol     += rs.Fields("Vol");
	totVolCost += rs.Fields("VolCost");
	totPdfo    += rs.Fields("Pdfo");
	totVz      += rs.Fields("Vz");
	totPurCost += rs.Fields("PurCost");
	rs.MoveNext();
}
rs.Close();
Solaren.Close();

var th = ['<TH ALIGN="LEFT" COLSPAN="3">Всього: ', i, '</TH>',
	Tag.Write("TH", 2, totVol.toDelimited(0)),
	Tag.Write("TH", 2, totVolCost.toDelimited(2)),
	Tag.Write("TH", 2, totPdfo.toDelimited(2)),
	Tag.Write("TH", 2, totVz.toDelimited(2)),
	Tag.Write("TH", 2, totPurCost.toDelimited(2))
],
tr = Tag.Write("TR", -1, th.join(""));
ResponseText.push(tr);
ResponseText.push('</TABLE></BODY></HTML>');
Response.Write(ResponseText.join("\n"))%>


