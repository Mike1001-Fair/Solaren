<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
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
	var rs = Cmd.Execute();
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
} finally {
	Solaren.EOF(rs, 'Iнформацiю не знайдено');
	Html.SetPage("Список лiчильникiв", User.RoleId)
}

var ResponseText = ['<BODY CLASS="MainBody">\n',
	'<H3 CLASS="H3Text">Список лiчильникiв</H3>\n',
	'<TABLE CLASS="InfoTable">\n',
	'<TR><TH ROWSPAN="2">Рахунок</TH><TH ROWSPAN="2">Споживач</TH><TH COLSPAN="6">Лічильник</TH></TR>\n',
	'<TR><TH>Номер</TH><TH>Монтаж</TH><TH>Р</TH><TH>К</TH><TH>Прийом</TH><TH>Видача</TH></TR>\n'
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
		Tag.Write("TD", -1, rs.Fields("RetVal")), '</TR>\n'
	];
	ResponseText.push(row.join(""));
	rs.MoveNext();
} rs.Close();
Connect.Close();
ResponseText.push(Html.GetFooterRow(8, i));
Response.Write(ResponseText.join(""))%>