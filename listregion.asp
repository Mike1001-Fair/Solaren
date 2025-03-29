<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
RegionName = Request.Form("RegionName");
User.ValidateAccess(Authorized, "POST");

try {
	Solaren.SetCmd("ListRegion");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("RegionName", adVarChar, adParamInput, 10, RegionName));
		}
	}
	var rs = Solaren.Execute("ListRegion");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Області")
}

var ResponseText = ['<BODY CLASS="MainBody">',
	'<H3 CLASS="H3Text">' + Html.Title + '</H3>',
	'<TABLE CLASS="InfoTable">',
	'<TR><TH>№</TH><TH>Назва</TH></TR>'
];

for (var i=0; !rs.EOF; i++) {
	var url = Html.GetLink("editregion.asp?RegionId=", rs.Fields("Id"), rs.Fields("RegionName")),
	row = ['<TR>', Tag.Write("TD", -1, rs.Fields("SortCode")),
		Tag.Write("TD", -1, url), '</TR>'
	];
	ResponseText.push(row.join(""));
	rs.MoveNext();
}
rs.Close();
Solaren.Close();
ResponseText.push(Html.GetFooterRow(2, i));
Response.Write(ResponseText.join("\n"))%>
