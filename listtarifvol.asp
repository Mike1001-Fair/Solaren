<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE VIRTUAL="Solaren/Include/list.inc" -->
<!-- #INCLUDE FILE="Include/tarif.inc" -->
<% var Authorized = User.RoleId == 1;
User.CheckAccess(Authorized, "POST");

with (Request) {
	BegMonth = String(Form("BegMonth")),
	EndMonth = String(Form("EndMonth"));
}

try {
	Solaren.SetCmd("ListTarifVol");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("BegMonth", adVarChar, adParamInput, 10, BegMonth));
			Append(CreateParameter("EndMonth", adVarChar, adParamInput, 10, EndMonth));
		}
	}
	var rs = Solaren.Execute("ListTarifVol");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetHead("Обсяги по тарифам");
}

var Range = Month.GetRange(BegMonth, EndMonth),
totPurVol = totVolCost = 0,
Output = ['<BODY CLASS="PrnBody">',
	'<H3 CLASS="H3PrnTable">Обсяги по тарифам</H3><SPAN CLASS="H3PrnTable">перiод: ' + Range + '</SPAN>',
	'<TABLE CLASS="PrnTable">',
	'<TR><TH ROWSPAN="2">Дата вводу<BR>в експлуатацiю</TH><TH ROWSPAN="2">Група</TH><TH>Тариф</TH><TH>Обсяг</TH><TH>Вартiсть</TH></TR>',
	'<TR><TH>коп</TH><TH>кВт&#183;год</TH><TH>грн</TH><TR>'
];

for (var i=0; !rs.EOF; i++) {
	var ExpDateBeg = Month.GetYMD(rs.Fields("ExpDateBeg")),
	ExpDateEnd = Month.GetYMD(rs.Fields("ExpDateEnd")),
	ExpPeriod = [ExpDateBeg.formatDate("-"), ExpDateEnd.formatDate("-")],
	row = ['<TR>', Tag.Write("TD", -1, ExpPeriod.join(' &ndash; ')),
		Tag.Write("TD", 1, Tarif.Group[rs.Fields("GroupId").Value]),
		Tag.Write("TD", 2, rs.Fields("Tarif").Value.toDelimited(2)),
		Tag.Write("TD", 2, rs.Fields("PurVol").Value.toDelimited(0)),
		Tag.Write("TD", 2, rs.Fields("VolCost").Value.toDelimited(2)), '</TR>',
	];
	Output.push(row.join(""));
	totPurVol += rs.Fields("PurVol");
	totVolCost += rs.Fields("VolCost");
	rs.MoveNext();
}
rs.Close();
Solaren.Close();
var footer = [
	'<TR><TH ALIGN="LEFT" COLSPAN="3">Всього: ', i, '</TH>',
	Tag.Write("TH", 2, totPurVol.toDelimited(0)),
	Tag.Write("TH", 2, totVolCost.toDelimited(2)),
	'</TR>\n</TABLE></BODY></HTML>'
];
Output.push(footer.join(""));
Response.Write(Output.join("\n"))%>


