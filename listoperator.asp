<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/list.set" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
OperatorName = Request.Form("OperatorName");
User.CheckAccess(Authorized, "POST");

try {
	Db.SetCmd("ListOperator");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("OperatorName", adVarChar, adParamInput, 10, OperatorName));
		}
	}
	var rs = Db.Execute("ListOperator");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Оператори")
}

var Output = ['<BODY CLASS="MainBody">',
	'<H3 CLASS="H3Text">Оператори</H3>',
	'<TABLE CLASS="InfoTable">',
	'<TR><TH>№</TH><TH>ЄДРПОУ</TH><TH>Назва</TH></TR>'
];

for (var i=0; !rs.EOF; i++) {
	var url = Html.GetLink("editoperator.asp?OperatorId=", rs.Fields("OperatorId"), rs.Fields("OperatorName"));
	row = ['<TR>', Tag.Write("TD", -1, rs.Fields("SortCode")),
		Tag.Write("TD", -1, rs.Fields("EdrpoCode")),
		Tag.Write("TD", -1, url), '</TR>'
	];
	Output.push(row.join(""));
	rs.MoveNext();
}
rs.Close();
Db.Close();
Output.push(Html.GetFooterRow(3, i));
Response.Write(Output.join("\n"))%>


