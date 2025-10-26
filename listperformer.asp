<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1,
Form = Solaren.Map(Request.Form);
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("ListPerformer");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("PerformerName", adVarChar, adParamInput, 10, Form.PerformerName));
		}
	}
	var rs = Solaren.Execute("ListPerformer");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Виконавці");
}

var ResponseText = ['<BODY CLASS="MainBody">',
	'<H3 CLASS="H3Text">' + Html.Title + '</H3>',
	'<TABLE CLASS="InfoTable">',
	'<TR><TH>Логін</TH><TH>ПIБ</TH><TH>Телефон</TH><TH>ЦОС</TH></TR>'
];

for (var i=0; !rs.EOF; i++) {
	var url = Html.GetLink("editperformer.asp?PerformerId=", rs.Fields("Id"), rs.Fields("UserName")),
	td = [Tag.Write("TD", 0, url),
		Tag.Write("TD", 0, rs.Fields("FullName")),
		Tag.Write("TD", 0, rs.Fields("Phone")),
		Tag.Write("TD", 0, rs.Fields("BranchName"))
	],
	tr = Tag.Write("TR", -1, td.join(""));
	ResponseText.push(tr);
	rs.MoveNext();
}
rs.Close();
Solaren.Close();
ResponseText.push(Html.GetFooterRow(4, i));
Response.Write(ResponseText.join("\n"))%>

