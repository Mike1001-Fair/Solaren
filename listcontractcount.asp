<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = User.RoleId == 1,
ReportDate = String(Request.Form("ReportDate"));
User.ValidateAccess(Authorized, "POST");

try {
	Solaren.SetCmd("ListContractCount");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("ReportDate", adVarChar, adParamInput, 10, ReportDate));

		}
	}
	var rs = Solaren.Execute("ListContractCount");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetHead("Кiлькiсть договорiв");
}

var totContractNumber = totContractPower = 0,
Header = ['ЦОС', 'Кiлькiсть', 'Потужнiсть'],
ResponseText = ['<BODY CLASS="PrnBody">',
	'<H3 CLASS="H3PrnTable">' + Html.Title + '</H3><SPAN CLASS="H3PrnTable">станом на: ' + ReportDate.formatDate("-") + '</SPAN>',
	'<TABLE CLASS="PrnTable">',
	Html.GetHeadRow(Header)
];

for (var i=0; !rs.EOF; i++) {
	var td = [Tag.Write("TD", -1, rs.Fields("BranchName")),
		Tag.Write("TD", 2, rs.Fields("ContractNumber").value.toDelimited(0)),
		Tag.Write("TD", 2, rs.Fields("ContractPower").value.toDelimited(2))
	],
	tr = Tag.Write("TR", -1, td.join(""));
	ResponseText.push(tr);
	totContractNumber += rs.Fields("ContractNumber");
	totContractPower += rs.Fields("ContractPower");
	rs.MoveNext();
}
rs.Close();
Solaren.Close();
var th = [Tag.Write("TH", 0, "Всього: " + i),
	Tag.Write("TH", 2, totContractNumber.toDelimited(0)),
	Tag.Write("TH", 2, totContractPower.toDelimited(2))
],
tr = Tag.Write("TR", -1, th.join(""));
ResponseText.push(tr);
ResponseText.push('</TABLE></BODY></HTML>');
Response.Write(ResponseText.join("\n"))%>