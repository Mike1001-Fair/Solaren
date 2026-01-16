<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/list.set" -->
<% var Authorized = User.RoleId == 1;
User.CheckAccess(Authorized, "POST");

with (Request) {
	var AenName = Form("AenName"),
	Deleted = Form("Deleted") == "on";
}

try {
	Db.SetCmd("ListAen");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("AenName", adVarChar, adParamInput, 10, AenName));
			Append(CreateParameter("Deleted", adBoolean, adParamInput, 1, Deleted));
		}
	}
	var rs = Db.Execute("ListAen");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Список РЕМ")
}

var Output = ['<BODY CLASS="MainBody">',
	'<H3 CLASS="H3Text">Список РЕМ</H3>',
	'<TABLE CLASS="InfoTable">',
	'<TR><TH>№</TH><TH>Назва</TH></TR>'
];

for (var i=0; !rs.EOF; i++) {
	var url = ['<A href="editaen.asp?AenId=', rs.Fields("AenId"), '">', rs.Fields("AenName"), '</A>'],
	row = ['<TR>', Tag.Write("TD", 1, rs.Fields("SortCode")),
		Tag.Write("TD", 0, url.join("")), '</TR>'
	];
	Output.push(row.join(""));
	rs.MoveNext();
}
rs.Close();
Db.Close();
Output.push(Html.GetFooterRow(2, i));
Response.Write(Output.join("\n"))%>

