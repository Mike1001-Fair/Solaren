<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId > 0 && User.RoleId < 3;
User.ValidateAccess(Authorized, "POST");

with (Request) {
	var ContractId = Form("ContractId"),
	BegDate        = Form("BegDate"),
	EndDate        = Form("EndDate"),
	ContractName   = Form("ContractName");
}

try {
	Solaren.SetCmd("ListIndicator");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("ContractId", adVarChar, adParamInput, 10, ContractId));
			Append(CreateParameter("BegDate", adVarChar, adParamInput, 10, BegDate));
			Append(CreateParameter("EndDate", adVarChar, adParamInput, 10, EndDate));
		}
	}
	var rs = Solaren.Execute("ListIndicator");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Показники лiчильника");
}

var Header = ['Номер', 'Дата', 'Прийом', 'Видача'],
ResponseText = ['<BODY CLASS="MainBody">',
	'<TABLE CLASS="H3Text">',
	Tag.Write("CAPTION", -1, Html.Title),
	'<TR><TD ALIGN="RIGHT">Споживач:</TD><TD ALIGN="LEFT">' + ContractName + '</TD></TR>',
	'</TABLE>',
	'<TABLE CLASS="InfoTable">',
	Html.GetHeadRow(Header)
];

for (var i=0; !rs.EOF; i++) {
var url = ['<A href="editindicator.asp?IndicatorId=', rs.Fields("Id"), '">', rs.Fields("ReportDate"), '</A>'],
	row = ['<TR>', Tag.Write("TD", -1, rs.Fields("MeterCode")),
		Tag.Write("TD", -1, url.join("")),
		Tag.Write("TD", 2, rs.Fields("RecVal").value.toDelimited(0)),
		Tag.Write("TD", 2, rs.Fields("RetVal").value.toDelimited(0)), '</TR>',
		
	];
	ResponseText.push(row.join(""));
	rs.MoveNext();
}
rs.Close();
Solaren.Close();
ResponseText.push(Html.GetFooterRow(4, i));
Response.Write(ResponseText.join("\n"))%>
