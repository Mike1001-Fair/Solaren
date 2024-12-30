<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/locality.inc" -->
<!-- #INCLUDE FILE="Include/street.inc" -->
<% var Authorized = User.RoleId == 1;
User.ValidateAccess(Authorized, "POST");

with (Request) {
    var CustomerId = String(Form("CustomerId")),
	PAN        = String(Form("PAN"));
}

try {
	Solaren.SetCmd("ListContract");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("CustomerId", adVarChar, adParamInput, 10, CustomerId));
			Append(CreateParameter("PAN", adVarChar, adParamInput, 10, PAN));
		}
	}
	var rs = Solaren.Execute("ListContract", "Iнформацiю не знайдено");
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
} finally {
	Html.SetPage("Список договорiв", User.RoleId)
}

var ResponseText = ['\n<BODY CLASS="MainBody">\n' +
	'<H3 CLASS="H3Text">Список договорiв</H3>\n' +
	'<TABLE CLASS="InfoTable">\n' +
	'<TR><TH>Рахунок</TH><TH>Споживач</TH><TH>Адреса</TH><TH>Дата</TH><TH>ЦОС</TH><TH>Потужнiсть</TH></TR>\n'
];

for (var i=totPwr=0; !rs.EOF; i++) {
	var ContractAddress = [Locality.Type[rs.Fields("LocalityType")],
		rs.Fields("LocalityName") + ",",
		Street.Type[rs.Fields("StreetType")],
		rs.Fields("StreetName"),
		rs.Fields("HouseId")
	],
	row = ['<TR><TD>' + '<A href="editcontract.asp?ContractId=' + rs.Fields("ContractId") + '">' + rs.Fields("PAN") + '</A></TD>',
		Html.Write("TD","LEFT") + rs.Fields("CustomerName"),
		Html.Write("TD","") + ContractAddress.join(" "),
		Html.Write("TD","") + rs.Fields("ContractDate"),
		Html.Write("TD","") + rs.Fields("BranchName"),
		Html.Write("TD","RIGHT") + rs.Fields("ContractPower").value.toDelimited(1) + '</TD></TR>\n'
	];
	ResponseText.push(row.join(""));
	totPwr += rs.Fields("ContractPower");
	rs.MoveNext();
} rs.Close(); Connect.Close();
var footer = ['<TR><TH ALIGN="LEFT" COLSPAN="5">Всього: ' + i,
	Html.Write("TH","RIGHT") + totPwr.toDelimited(1),
	'</TH></TR>\n</TABLE></BODY></HTML>'
];
ResponseText.push(footer.join(""));
Response.Write(ResponseText.join(""))%>
