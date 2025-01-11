<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->

<% var Authorized = User.RoleId < 2,
CompanyName = Request.Form("CompanyName");
User.ValidateAccess(Authorized, "POST")

try {
	Solaren.SetCmd("ListCompany");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("CompanyName", adVarChar, adParamInput, 10, CompanyName));
		}
	}
	var rs = Solaren.Execute("ListCompany", "Iнформацiю не знайдено");
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
} finally {
	Html.SetPage("Список компаній", User.RoleId);
}

var Header = ['ЄДРПОУ', 'ІПН', 'Назва', 'Телефон'],
ResponseText = ['<BODY CLASS="MainBody">\n',
	'<H3 CLASS="H3Text">', Html.Title, '</H3>\n',
	'<TABLE CLASS="InfoTable">\n',
	Html.GetHeadRow(Header)
];

for (var i=0; !rs.EOF; i++) {
	var url = ['<A href="editcompany.asp?CompanyId=', rs.Fields("Id"), '">', rs.Fields("CompanyName"), '</A>'],
	row = ['<TR>', Tag.Write("TD", -1, rs.Fields("CompanyCode")),
		Tag.Write("TD", -1, rs.Fields("TaxCode")),
		Tag.Write("TD", -1, url.join("")),
		Tag.Write("TD", -1, rs.Fields("Phone")), '</TR>\n'
	];
	ResponseText.push(row.join(""));
	rs.MoveNext();
}

rs.Close();
Connect.Close();
ResponseText.push(Html.GetFooterRow(4, i));
Response.Write(ResponseText.join(""))%>