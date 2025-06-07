<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = User.RoleId == 1;
User.ValidateAccess(Authorized, "POST");
	
with (Request) {
    var GroupId = Form("GroupId"),
	GroupName = Form("GroupName"),
	BegDate   = Form("BegDate");
}

try {
	Solaren.SetCmd("ListTarif");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("GroupId", adVarChar, adParamInput, 10, GroupId));
			Append(CreateParameter("BegDate", adVarChar, adParamInput, 10, BegDate));
		}
	}
	var rs = Solaren.Execute("ListTarif");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Список тарифiв")
}

var Header = ['з', 'по', 'коп'],
ResponseText = ['<BODY CLASS="MainBody">',
	'<H3 CLASS="H3Text">Список тарифiв<SPAN>Група: ' + GroupName + '</SPAN></H3>',
	'<TABLE CLASS="InfoTable">',
	'<TR><TH COLSPAN="2">Дiє</TH><TH ROWSPAN="2">Дата вводу в<BR>експлуатацiю</TH><TH>Тариф</TH></TR>',
	Html.GetHeadRow(Header)
];

for (var i=0; !rs.EOF; i++) {
	var url = Html.GetLink("edittarif.asp?TarifId=", rs.Fields("Id"), rs.Fields("Tarif").value.toDelimited(2)),
	BegDate = Month.GetYMD(rs.Fields("BegDate").value),
	EndDate = Month.GetYMD(rs.Fields("EndDate").value),
	ExpDateBeg = Month.GetYMD(rs.Fields("ExpDateBeg").value),
	ExpDateEnd = Month.GetYMD(rs.Fields("ExpDateEnd").value),
	range = Month.GetRange(ExpDateBeg, ExpDateEnd),
	td = [Tag.Write("TD", -1, BegDate.formatDate("-")),
		Tag.Write("TD", -1, EndDate.formatDate("-")),
		Tag.Write("TD", -1, range),
		Tag.Write("TD", 2, url)
	],
	tr = Tag.Write("TR", -1, td.join(""));
	ResponseText.push(tr);
	rs.MoveNext();
}
rs.Close();
Solaren.Close();
ResponseText.push(Html.GetFooterRow(4, i));
Response.Write(ResponseText.join("\n"))%>
