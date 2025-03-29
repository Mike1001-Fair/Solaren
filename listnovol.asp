<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = Session("RoleId") == 1 || Session("RoleId") == 2;
if (!Authorized) Message.Write(2, "Помилка авторизації");

try {
	Solaren.SetCmd("ListNoVol");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("OperDate", adVarChar, adParamInput, 10, Month.Date[1]));
		}
	}
	var rs = Solaren.Execute("ListNoVol");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Звіт")
}

var ResponseText = ['<BODY CLASS="MainBody">',
	'<H3 CLASS="H3Text">Договора без обсягiв<SPAN>' + Month.GetPeriod(Month.GetMonth(1), 0) + '</SPAN></H3>',
	'<TABLE CLASS="InfoTable">',
	'<TR><TH>Споживач</TH><TH>Рахунок</TH><TH>ЦОС</TH></TR>'
];

for (var i=0; !rs.EOF; i++) {
	row = ['<TR>', Tag.Write("TD", -1, rs.Fields("CustomerName")),
		Tag.Write("TD", -1, rs.Fields("ContractPAN")),
		Tag.Write("TD", -1, rs.Fields("BranchName")), '</TR>'
	];
	ResponseText.push(row.join(""));
	rs.MoveNext();
}
rs.Close();
Solaren.Close();
ResponseText.push(Html.GetFooterRow(3, i));
Response.Write(ResponseText.join("\n"))%>