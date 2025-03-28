<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->

<% var Authorized = User.RoleId < 2,
BranchName = Request.Form("BranchName");
User.ValidateAccess(Authorized, "POST");

try {
	Solaren.SetCmd("ListBranch");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("BranchName", adVarChar, adParamInput, 10, BranchName));
		}
	}
	var rs = Solaren.Execute("ListBranch");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Список ЦОС");
}

var Header = ['№', 'Назва', 'Керiвник', 'Бухгалтер'],
ResponseText = ['<BODY CLASS="MainBody">',
	'<H3 CLASS="H3Text">' + Html.Title + '</H3>',
	'<TABLE CLASS="InfoTable">',
	Html.GetHeadRow(Header)
];

for (var i=0; !rs.EOF; i++) {
	var url = ['<A href="editbranch.asp?BranchId=', rs.Fields("BranchId"), '">', rs.Fields("BranchName"), '</A>'],
	row = ['<TR>', Tag.Write("TD", 2, rs.Fields("SortCode")),
		Tag.Write("TD", -1, url.join("")),
		Tag.Write("TD", -1, rs.Fields("ChiefName")),
		Tag.Write("TD", -1, rs.Fields("Accountant")), '</TR>'
	];
	ResponseText.push(row.join(""));
	rs.MoveNext();
}
rs.Close();
Solaren.Close();
ResponseText.push(Html.GetFooterRow(4, i));
Response.Write(ResponseText.join("\n"));
%>
