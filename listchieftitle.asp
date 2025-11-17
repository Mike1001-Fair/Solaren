<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
TitleName = Request.Form("TitleName");
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("ListChiefTitle");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("TitleName", adVarChar, adParamInput, 10, TitleName));
		}
	}
	var rs = Solaren.Execute("ListChiefTitle");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Посади")
}

var Output = ['<BODY CLASS="MainBody">',
	'<H3 CLASS="H3Text">' + Html.Title + '</H3>',
	'<TABLE CLASS="InfoTable">',
	'<TR><TH>Посада</TH></TR>'
];

for (var i=0; !rs.EOF; i++) {
	var url = Html.GetLink("editchieftitle.asp?ChiefTitleId=", rs.Fields("Id"), rs.Fields("Title1")),
	td =  [Tag.Write("TD", 0, url)],
	tr = Tag.Write("TR", -1, td.join(""));
	Output.push(tr);
	rs.MoveNext();
}
rs.Close();
Solaren.Close();
Output.push(Html.GetFooterRow(1, i));
Response.Write(Output.join("\n"))%>

