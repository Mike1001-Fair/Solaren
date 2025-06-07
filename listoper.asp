<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1;
User.ValidateAccess(Authorized, "POST");

with (Request) {
	var ContractId = Form("ContractId"),
	BegMonth       = String(Form("BegMonth")),
	EndMonth       = String(Form("EndMonth")),
	ContractName   = Form("ContractName"),
	Deleted        = Form("Deleted") == "on";
}

try {
	Solaren.SetCmd("ListOper");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("ContractId", adVarChar, adParamInput, 10, ContractId));
			Append(CreateParameter("BegMonth", adVarChar, adParamInput, 10, BegMonth));
			Append(CreateParameter("EndMonth", adVarChar, adParamInput, 10, EndMonth));
			Append(CreateParameter("Deleted", adBoolean, adParamInput, 1, Deleted));
		}
	}
	var rs = Solaren.Execute("ListOper");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Операції")
}

var totRetVol = totVolCost = 0,
ResponseText = ['<BODY CLASS="MainBody">',
	'<H3 CLASS="H3Text">Операції<SPAN>Договор: ' + ContractName + '</SPAN></H3>',
	'<TABLE CLASS="InfoTable">',
	'<TR><TH>З</TH><TH>По</TH><TH>Видача</TH><TH>Вартість</TH></TR>'
];

for (var i=0; !rs.EOF; i++) {
	var url = Html.GetLink("editoper.asp?FactVolId=", rs.Fields("Id"), rs.Fields("BegDate")),
	row = ['<TR>', Tag.Write("TD", -1, url),
		Tag.Write("TD", -1, rs.Fields("EndDate")),
		Tag.Write("TD", 2, rs.Fields("RetVol").value.toDelimited(0)),
		Tag.Write("TD", 2, rs.Fields("VolCost").value.toDelimited(2)), '</TR>'
	];
	ResponseText.push(row.join(""));
	totRetVol += rs.Fields("RetVol");
	totVolCost += rs.Fields("VolCost");
	rs.MoveNext()
} rs.Close();
Solaren.Close();
var footer = ['<TR><TH ALIGN="LEFT" COLSPAN="2">Всього: ', i, '</TH>',
	Tag.Write("TH", 2, totRetVol.toDelimited(0)),
	Tag.Write("TH", 2, totVolCost.toDelimited(2)),
	'</TR>\n</TABLE></BODY></HTML>'
];
ResponseText.push(footer.join(""));
Response.Write(ResponseText.join("\n"))%>

