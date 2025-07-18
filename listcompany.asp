<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->

<% var Authorized = User.RoleId < 2,
CompanyName = Request.Form("CompanyName");
User.ValidateAccess(Authorized, "POST");

try {
	Solaren.SetCmd("ListCompany");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("CompanyName", adVarChar, adParamInput, 10, CompanyName));
		}
	}
	var rs = Solaren.Execute("ListCompany");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Список компаній");
}

var Header = ['ЄДРПОУ', 'ІПН', 'Назва', 'Телефон'],
ResponseText = ['<BODY CLASS="MainBody">',
	'<H3 CLASS="H3Text">' + Html.Title + '</H3>',
	'<TABLE CLASS="InfoTable">',
	Html.GetHeadRow(Header)
];

for (var i=0; !rs.EOF; i++) {
	var url = Html.GetLink("editcompany.asp?CompanyId=", rs.Fields("Id"), rs.Fields("CompanyName")),
	td = [Tag.Write("TD", -1, rs.Fields("CompanyCode")),
		Tag.Write("TD", -1, rs.Fields("TaxCode")),
		Tag.Write("TD", -1, url),
		Tag.Write("TD", -1, rs.Fields("Phone"))
	],
	tr = Tag.Write("TR", -1, td.join(""));
	ResponseText.push(tr);
	rs.MoveNext();
}

rs.Close();
Solaren.Close();
ResponseText.push(Html.GetFooterRow(4, i));
Response.Write(ResponseText.join("\n"))%>


