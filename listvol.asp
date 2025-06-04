<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/referer.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1;
User.ValidateAccess(Authorized, "POST");

with (Request) {
    var ContractId   = Form("ContractId"),
	BegMonth     = String(Form("BegMonth")),
	EndMonth     = String(Form("EndMonth")),
	ContractName = Form("ContractName");
}

try {
	Solaren.SetCmd("ListVol");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("ContractId", adVarChar, adParamInput, 10, ContractId));
			Append(CreateParameter("BegMonth", adVarChar, adParamInput, 10, BegMonth));
			Append(CreateParameter("EndMonth", adVarChar, adParamInput, 10, EndMonth));
		}
	}
	var rs = Solaren.Execute("ListVol");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Обсяги")
}

var nVol = totRetVol = totRecVol = totSaldo = totnVol = 0,
Header = ['З', 'По', 'Прийом', 'Видача', 'Покупка', 'Потреби'],
ResponseText = ['<BODY CLASS="MainBody">',
	'<H3 CLASS="H3Text">' + Html.Title + '<SPAN>Договор: ' + ContractName + '</SPAN></H3>',
	'<TABLE CLASS="InfoTable">',
	Html.GetHeadRow(Header)
];

for (var i=0; !rs.EOF; i++) {
	var nVol = rs.Fields("RetVol") - rs.Fields("PurVol"),
	url = Html.GetLink("editfactvol.asp?FactVolId=", rs.Fields("Id"), rs.Fields("BegDate")),
	row = ['<TR>', Tag.Write("TD", -1, url),
		Tag.Write("TD", -1, rs.Fields("EndDate")),
		Tag.Write("TD", 2, rs.Fields("RecVol").value.toDelimited(0)),
		Tag.Write("TD", 2, rs.Fields("RetVol").value.toDelimited(0)),
		Tag.Write("TD", 2, rs.Fields("PurVol").value.toDelimited(0)),
		Tag.Write("TD", 2, nVol.toDelimited(0)), '</TR>'
	];
	ResponseText.push(row.join(""));
	totRecVol += rs.Fields("RecVol");
	totRetVol += rs.Fields("RetVol");
	totSaldo  += rs.Fields("PurVol");
	totnVol   += nVol;
	rs.MoveNext();
} rs.Close();
Solaren.Close();

var footer = ['<TR><TH ALIGN="LEFT" COLSPAN="2">Всього: ', i, '</TH>',
	Tag.Write("TH", 2, totRecVol.toDelimited(0)),
	Tag.Write("TH", 2, totRetVol.toDelimited(0)),
	Tag.Write("TH", 2, totSaldo.toDelimited(0)),
	Tag.Write("TH", 2, totnVol.toDelimited(0)),
	'</TR>\n</TABLE></BODY></HTML>'
];
ResponseText.push(footer.join(""));
Response.Write(ResponseText.join("\n"))%>

