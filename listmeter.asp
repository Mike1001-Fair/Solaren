<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->

<% var Authorized = User.RoleId == 1;
User.ValidateAccess(Authorized, "POST");

with (Request) {
    var ContractId = String(Form("ContractId")),
	MeterCode  = String(Form("MeterCode"));
}

try {
	Solaren.SetCmd("ListMeter");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("ContractId", adVarChar, adParamInput, 10, ContractId));
			Append(CreateParameter("MeterCode", adVarChar, adParamInput, 10, MeterCode));
		}
	}
	var rs = Solaren.Execute("ListMeter", "Iнформацiю не знайдено");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Список лiчильникiв", User.RoleId)
}

var Header = ['Номер', 'Монтаж', 'Р', 'К', 'Прийом', 'Видача'],
ResponseText = ['<BODY CLASS="MainBody">',
	'<H3 CLASS="H3Text">' + Html.Title + '</H3>',
	'<TABLE CLASS="InfoTable">',
	'<TR><TH ROWSPAN="2">Рахунок</TH><TH ROWSPAN="2">Споживач</TH><TH COLSPAN="6">Лічильник</TH></TR>',
	Html.GetHeadRow(Header)
];

for (var i=0; !rs.EOF; i++) {
	var url = ['<A href="editmeter.asp?MeterId=', rs.Fields("Id"), '">', rs.Fields("Code"), '</A>'],
	row = ['<TR>', Tag.Write("TD", 9, rs.Fields("PAN")),
		Tag.Write("TD", 0, rs.Fields("CustomerName")),
		Tag.Write("TD", 2, url.join("")),
		Tag.Write("TD", -1, rs.Fields("SetDate")),
		Tag.Write("TD", -1, rs.Fields("Capacity")),
		Tag.Write("TD", -1, rs.Fields("kTransForm")),
		Tag.Write("TD", -1, rs.Fields("RecVal")),
		Tag.Write("TD", -1, rs.Fields("RetVal")), '</TR>'
	];
	ResponseText.push(row.join(""));
	rs.MoveNext();
} rs.Close();
Solaren.Close();
ResponseText.push(Html.GetFooterRow(8, i));
Response.Write(ResponseText.join("\n"))%>
