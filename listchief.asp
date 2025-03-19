<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
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
}

Html.SetPage("Керiвники", User.RoleId)

var ResponseText = ['<BODY CLASS="MainBody">\n',
	'<H3 CLASS="H3Text">' + Html.Title + '</H3>\n',
	'<TABLE CLASS="InfoTable">\n',
	'<TR><TH>Посада</TH><TH>ПIБ</TH></TR>\n'
];

for (var i=0, row; !rs.EOF; i++) {
	row = ['<TR><TD>', rs.Fields("Title1"), '</TD>',
		Html.Write("TD",""),
		'<A href="editchief.asp?ChiefId=', rs.Fields("Id"), '">', rs.Fields("Name1"), '</A>',
		'</TD></TR>\n'
	];
	ResponseText.push(row.join(""));
	rs.MoveNext();
} rs.Close();Solaren.Close();
ResponseText.push(Html.GetFooterRow(2, i));
Response.Write(ResponseText.join(""))%>
