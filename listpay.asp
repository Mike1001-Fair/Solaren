<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = User.RoleId == 1;
User.ValidateAccess(Authorized, "POST");

with (Request) {
    var BegDate      = String(Form("BegDate")),
	EndDate      = String(Form("EndDate")),
	ContractId   = Form("ContractId"),
	ContractName = Form("ContractName");
}

try {
	Solaren.SetCmd("ListPay");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adInteger, adParamInput, 10, User.Id));
			Append(CreateParameter("BegDate", adVarChar, adParamInput, 10, BegDate));
			Append(CreateParameter("EndDate", adVarChar, adParamInput, 10, EndDate));
			Append(CreateParameter("ContractId", adInteger, adParamInput, 10, ContractId));
		}
	}
	var rs = Solaren.Execute("ListPay");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Список оплат")
}

var Period = [BegDate.formatDate("-")],
totalPay   = 0;
if (BegDate != EndDate) {
	Period.push(EndDate.formatDate("-"));
}

var Header = ['Дaта', 'Сума'],
ResponseText = ['<BODY CLASS="MainBody">',
	'<TABLE CLASS="H3Text">',
	Tag.Write("CAPTION", -1, Html.Title),
	'<TR>' + Tag.Write("TD", 2, 'Споживач:') + Tag.Write("TD", 0, ContractName) + '</TR>',
	'<TR>' + Tag.Write("TD", 2, 'Період:') + Tag.Write("TD", 0, Period.join(' &ndash; ')) + '</TR>',
	'</TABLE>',
	'<TABLE CLASS="InfoTable">',
	Html.GetHeadRow(Header)
];

for (var i=0; !rs.EOF; i++) {
	var url = ['<A href="editpay.asp?PayId=', rs.Fields("PayId"), '">', rs.Fields("PaySum").value.toDelimited(2), '</A>'],
	PayDate = Month.GetYMD(rs.Fields("PayDate").value),
	row = ['<TR>', Tag.Write("TD", -1, PayDate.formatDate("-")),
		Tag.Write("TD", 2, url.join("")), '</TR>'
	];
	ResponseText.push(row.join(""));
	totalPay += rs.Fields("PaySum").value;
	rs.MoveNext();
}
rs.Close();
Solaren.Close();
var footer = ['<TR><TH ALIGN="LEFT">Всього: ' + i,
	Tag.Write("TH", 2, totalPay.toDelimited(2)) + '</TR>\n',
	'</TABLE></BODY></HTML>'
];
ResponseText.push(footer.join(""));
Response.Write(ResponseText.join("\n"))%>

