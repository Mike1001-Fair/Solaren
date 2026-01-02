<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/list.set" -->
<% var Authorized = User.RoleId > 0 && User.RoleId < 3;
User.CheckAccess(Authorized, "GET");

try {
	Solaren.SetCmd("ListNoVol");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("OperDate", adVarChar, adParamInput, 10, Month.Date[1]));
		}
	}
	var rs = Solaren.Execute("ListNoVol");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Звіт")
}

var Period = Month.GetPeriod(Month.GetMonth(1), 0),
Header = ['Споживач', 'Рахунок', 'ЦОС'],
Output = ['<BODY CLASS="MainBody">',
	'<H3 CLASS="H3Text">Договора без обсягiв<SPAN>' + Period + '</SPAN></H3>',
	'<TABLE CLASS="InfoTable">',
	Html.GetHeadRow(Header)
];

for (var i=0; !rs.EOF; i++) {
	var row = ['<TR>', Tag.Write("TD", -1, rs.Fields("CustomerName")),
		Tag.Write("TD", -1, rs.Fields("ContractPAN")),
		Tag.Write("TD", -1, rs.Fields("BranchName")), '</TR>'
	];
	Output.push(row.join(""));
	rs.MoveNext();
}
rs.Close();
Solaren.Close();
Output.push(Html.GetFooterRow(3, i));
Response.Write(Output.join("\n"))%>

