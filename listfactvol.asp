<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE VIRTUAL="Solaren/Set/list.set" -->
<% var Authorized = User.RoleId == 1;
User.CheckAccess(Authorized, "POST");

with (Request) {
	var ContractId = Form("ContractId"),
	BegMonth       = String(Form("BegMonth")),
	EndMonth       = String(Form("EndMonth"));
}

try {
	Solaren.SetCmd("ListFactVol");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("ContractId", adVarChar, adParamInput, 10, ContractId));
			Append(CreateParameter("BegMonth", adVarChar, adParamInput, 10, BegMonth));
			Append(CreateParameter("EndMonth", adVarChar, adParamInput, 10, EndMonth));
		}
	}
	var rs = Solaren.Execute("ListFactVol");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetHead("Звiт", 0);
}

var Range = Month.GetRange(BegMonth, EndMonth),
totRetVol = 0, totRecVol = 0, totSaldo = 0, totnVol = 0,
Header = ['Рахунок', 'З', 'По', 'Споживач', 'Прийом', 'Видача', 'Покупка', 'Потреби'],
Output = ['\n<BODY CLASS="PrnBody">',
	'<H3 CLASS="H3PrnTable">Баланс</H3><SPAN CLASS="H3PrnTable">перiод: ' + Range + '</SPAN>',
	'<TABLE CLASS="PrnTable">',
	Html.GetHeadRow(Header)
];

for (var i=0; !rs.EOF; i++) {
	var nVol = rs.Fields("RetVol") - rs.Fields("PurVol"),
	row = ['<TR>', Tag.Write("TD", 2, rs.Fields("ContractPAN")),
		Tag.Write("TD", -1, rs.Fields("BegDate")),
		Tag.Write("TD", -1, rs.Fields("EndDate")),
		Tag.Write("TD", -1, rs.Fields("CustomerName")),
		Tag.Write("TD", 2, rs.Fields("RecVol").Value.toDelimited(0)),
		Tag.Write("TD", 2, rs.Fields("RetVol").Value.toDelimited(0)),
		Tag.Write("TD", 2, rs.Fields("PurVol").Value.toDelimited(0)),
		Tag.Write("TD", 2, nVol.toDelimited(0)), '</TR>'
	];
	Output.push(row.join(""));
	totRecVol += rs.Fields("RecVol");
	totRetVol += rs.Fields("RetVol");
	totSaldo  += rs.Fields("PurVol");
	totnVol   += nVol;
	rs.MoveNext()
}
rs.Close();
Solaren.Close();

var footer = [
	'<TR><TH ALIGN="LEFT" COLSPAN="4">Всього: ', i, '</TH>',
	Tag.Write("TH", 2, totRecVol.toDelimited(0)),
	Tag.Write("TH", 2, totRetVol.toDelimited(0)),
	Tag.Write("TH", 2, totSaldo.toDelimited(0)),
	Tag.Write("TH", 2, totnVol.toDelimited(0)),
	'</TR>\n</TABLE></BODY></HTML>'
];
Output.push(footer.join(""));
Response.Write(Output.join("\n"))%>

