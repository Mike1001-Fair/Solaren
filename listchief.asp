<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Include/list.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
ChiefName = Request.Form("ChiefName");
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("ListChief");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("ChiefName", adVarChar, adParamInput, 10, ChiefName));
		}
	}
	var rs = Solaren.Execute("ListChief");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Керiвники")
}

var Output = ['<BODY CLASS="MainBody">',
	'<H3 CLASS="H3Text">' + Html.Title + '</H3>',
	'<TABLE CLASS="InfoTable">',
	'<TR><TH>Посада</TH><TH>ПIБ</TH></TR>'
];

for (var i=0, row; !rs.EOF; i++) {
	var url = Html.GetLink("editchief.asp?ChiefId=", rs.Fields("Id"), rs.Fields("Name1")),
	td =  [Tag.Write("TD", 0, rs.Fields("Title1")),
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


