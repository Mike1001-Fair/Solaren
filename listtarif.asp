<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1;
User.ValidateAccess(Authorized, "POST");

with (Request) {
    var GroupId   = Form("GroupId"),
	GroupName = Form("GroupName"),
	BegDate   = Form("BegDate");
}

try {
	Solaren.SetCmd("ListTarif");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("GroupId", adVarChar, adParamInput, 10, GroupId));
			Append(CreateParameter("BegDate", adVarChar, adParamInput, 10, BegDate));
		}
	}
	var rs = Solaren.Execute("ListTarif", "Iнформацiю не знайдено");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Список тарифiв", User.RoleId)
}

var Header = ['з', 'по', 'коп'],
ResponseText = ['<BODY CLASS="MainBody">',
	'<H3 CLASS="H3Text">Список тарифiв<SPAN>Група: ' + GroupName + '</SPAN></H3>',
	'<TABLE CLASS="InfoTable">',
	'<TR><TH COLSPAN="2">Дiє</TH><TH ROWSPAN="2">Дата вводу в<BR>експлуатацiю</TH><TH>Тариф</TH></TR>',
	Html.GetHeadRow(Header)
];

for (var i=0; !rs.EOF; i++) {
	var url = ['<A href="edittarif.asp?TarifId=', rs.Fields("Id"), '">', rs.Fields("Tarif").value.toDelimited(2), '</A>'],
	period = [rs.Fields("ExpDateBeg"), rs.Fields("ExpDateEnd")],
	row = ['<TR>', Tag.Write("TD", -1, rs.Fields("BegDate")),
		Tag.Write("TD", -1, rs.Fields("EndDate")),
		Tag.Write("TD", -1, period.join(' &ndash; ')),
		Tag.Write("TD", 2, url.join("")), '</TR>'
	];
	ResponseText.push(row.join(""));
	rs.MoveNext();
}
rs.Close();
Connect.Close();
ResponseText.push(Html.GetFooterRow(4, i));
Response.Write(ResponseText.join("\n"))%>