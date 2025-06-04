<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/referer.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2;
DocName = Request.Form("DocName");
User.ValidateAccess(Authorized, "POST");

try {
	Solaren.SetCmd("ListChiefDoc");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("DocName", adVarChar, adParamInput, 10, DocName));
		}
	}
	var rs = Solaren.Execute("ListChiefDoc");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Документи керівника")
}

var ResponseText = ['<BODY CLASS="MainBody">',
	'<H3 CLASS="H3Text">' + Html.Title + '</H3>',
	'<TABLE CLASS="InfoTable">',
	'<TR><TH>№</TH><TH>Назва</TH></TR>'
];

for (var i=0; !rs.EOF; i++) {
	var url = Html.GetLink("editchiefdoc.asp?DocId=", rs.Fields("Id"), rs.Fields("DocName")),
	td =  [Tag.Write("TD", 1, rs.Fields("SortCode")),
		Tag.Write("TD", 0, url)
	],
	tr = Tag.Write("TR", -1, td.join(""));
	ResponseText.push(tr);
	rs.MoveNext();
}
rs.Close();
Solaren.Close();
ResponseText.push(Html.GetFooterRow(2, i));
Response.Write(ResponseText.join("\n"))%>

