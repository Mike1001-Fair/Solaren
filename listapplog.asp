<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<% var Authorized = User.RoleId == 1;
User.ValidateAccess(Authorized, "POST");

with (Request) {
	var BegDate = String(Form("BegDate")),
	EndDate     = String(Form("EndDate")),
	EventType   = Form("EventType"),
	EventName   = Form("EventName"),
	Period      = BegDate.formatDate("-"),
	FinalDate   = EndDate.formatDate("-");
}

if (Period != FinalDate) Period += ' &ndash; ' + FinalDate;

try {
	Solaren.SetCmd("ListAppLog");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("BegDate", adVarChar, adParamInput, 10, BegDate));
			Append(CreateParameter("EndDate", adVarChar, adParamInput, 10, EndDate));
			Append(CreateParameter("EventType", adVarChar, adParamInput, 10, EventType));
		}
	}
	var rs = Solaren.Execute("ListAppLog");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Журнал", User.RoleId)
}

var ResponseText = ['<BODY CLASS="MainBody">',
	'<TABLE CLASS="H3Text">',
	'<CAPTION>Журнал</CAPTION>',
	'<TR><TD ALIGN="RIGHT">Подія:</TD><TD ALIGN="LEFT">' + EventName + '</TD></TR>',
	'<TR><TD ALIGN="RIGHT">Період:</TD><TD ALIGN="LEFT">' + Period + '</TD></TR>',
	'</TABLE>',
	'<TABLE CLASS="InfoTable">',
	'<TR><TH>Дaта</TH><TH>Повідомлення</TH></TR>'
];

for (var i=0; !rs.EOF; i++) {
	var row = ['<TR>', Tag.Write("TD", -1, rs.Fields("EventDate")),
		Tag.Write("TD", -1, rs.Fields("EventText")), '</TR>'
	];
	ResponseText.push(row.join(""));
	rs.MoveNext();
}
rs.Close();
Solaren.Close();
ResponseText.push(Html.GetFooterRow(2, i));
Response.Write(ResponseText.join("\n"))%>
