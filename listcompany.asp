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
}

Html.SetPage("Список компаній", User.RoleId);

var ResponseText = ['<BODY CLASS="MainBody">\n',
	'<H3 CLASS="H3Text">' + Html.Title + '</H3>\n',
	'<TABLE CLASS="InfoTable">\n',
	'<TR><TH>ЄДРПОУ</TH><TH>ІПН</TH><TH>Назва</TH><TH>Телефон</TH></TR>\n'
];

for (var i=0, row; !rs.EOF; i++) {
	row = ['<TR><TD>' + rs.Fields("CompanyCode"),
		Html.Write("TD","") + rs.Fields("TaxCode"),
		Html.Write("TD","") + '<A href="editcompany.asp?CompanyId=' + rs.Fields("Id") + '">' + rs.Fields("CompanyName") + '</A></TD>',
		Html.Write("TD","") + rs.Fields("Phone"),
		'</TD></TR>\n'
	];
	ResponseText.push(row.join(""));
	rs.MoveNext();
}

rs.Close();
Connect.Close();
ResponseText.push(Html.GetFooterRow(4, i));
Response.Write(ResponseText.join(""))%>