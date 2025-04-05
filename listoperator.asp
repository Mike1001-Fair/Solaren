<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
OperatorName = Request.Form("OperatorName");
User.ValidateAccess(Authorized, "POST");

try {
	Solaren.SetCmd("ListOperator");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("OperatorName", adVarChar, adParamInput, 10, OperatorName));
		}
	}
	var rs = Solaren.Execute("ListOperator");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Оператори")
}

var ResponseText = ['<BODY CLASS="MainBody">',
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
	ResponseText.push(row.join(""));
	rs.MoveNext();
}
rs.Close();
Solaren.Close();
ResponseText.push(Html.GetFooterRow(3, i));
Response.Write(ResponseText.join("\n"))%>

