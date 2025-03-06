<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
BankName = Request.Form("BankName");
User.ValidateAccess(Authorized, "POST");

try {
	Solaren.SetCmd("ListBank");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("BankName", adVarChar, adParamInput, 10, BankName));
		}
	}
	var rs = Solaren.Execute("ListBank", "Iнформацiю не знайдено");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Список банків", User.RoleId)
}

var Header = ['ЄДРПОУ', 'МФО', 'Найменування'],
ResponseText = ['<BODY CLASS="MainBody">',
	'<H3 CLASS="H3Text">' + Html.Title + '</H3>',
	'<TABLE CLASS="InfoTable">',
	Html.GetHeadRow(Header)
];

for (var i=0; !rs.EOF; i++) {
	var url = ['<A href="editbank.asp?BankId=', rs.Fields("Id"), '">', rs.Fields("BankName"), '</A>'],
	row = ['<TR>', Tag.Write("TD", -1, rs.Fields("EdrpoCode")),
		Tag.Write("TD", -1, rs.Fields("MfoCode")),
		Tag.Write("TD", -1, url.join("")), '</TR>'
	];
	ResponseText.push(row.join(""));
	rs.MoveNext();
}
rs.Close();
Connect.Close();
ResponseText.push(Html.GetFooterRow(3, i));
Response.Write(ResponseText.join("\n"))%>
