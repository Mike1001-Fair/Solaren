<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1,
BegDate = Request.Form("BegDate");
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("ListPdfo");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("BegDate", adVarChar, adParamInput, 10, BegDate));
		}
	}
	var rs = Solaren.Execute("ListPdfo");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Ставка ПДФО");
}

var ResponseText = ['<BODY CLASS="MainBody">',
	'<H3 CLASS="H3Text">' + Html.Title + '</H3>',
	'<TABLE CLASS="InfoTable">',
	'<TR><TH>Дiє з</TH><TH>по</TH><TH>Ставка</TH></TR>'
];

for (var i=0; !rs.EOF; i++) {	
	var url = Html.GetLink("editpdfo.asp?PdfoId=", rs.Fields("Id"), rs.Fields("PdfoTax")),
	td = [Tag.Write("TD", -1, rs.Fields("BegDate")),
		Tag.Write("TD", -1, rs.Fields("EndDate")),
		Tag.Write("TD", 2, url)
	],
	tr = Tag.Write("TR", -1, td.join(""));
	ResponseText.push(tr);
	rs.MoveNext();
}
rs.Close();
Solaren.Close();
ResponseText.push(Html.GetFooterRow(3, i));
Response.Write(ResponseText.join("\n"))%>


