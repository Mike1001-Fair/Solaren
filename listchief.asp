<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/referer.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
ChiefName = Request.Form("ChiefName");
User.ValidateAccess(Authorized, "POST");

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

var ResponseText = ['<BODY CLASS="MainBody">',
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
	ResponseText.push(tr);
	rs.MoveNext();
}
rs.Close();
Solaren.Close();
ResponseText.push(Html.GetFooterRow(2, i));
Response.Write(ResponseText.join("\n"))%>


