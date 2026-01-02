<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/list.set" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2;
DocName = Request.Form("DocName");
User.CheckAccess(Authorized, "POST");

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

var Output = ['<BODY CLASS="MainBody">',
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
	Output.push(tr);
	rs.MoveNext();
}
rs.Close();
Solaren.Close();
Output.push(Html.GetFooterRow(2, i));
Response.Write(Output.join("\n"))%>

