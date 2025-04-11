<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/locality.inc" -->
<!-- #INCLUDE FILE="Include/street.inc" -->
<% var Authorized = User.RoleId == 1;
User.ValidateAccess(Authorized, "POST");

with (Request) {
    var CustomerId = Form("CustomerId"),
	PAN = Form("PAN");
}

try {
	Solaren.SetCmd("ListContract");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("CustomerId", adVarChar, adParamInput, 10, CustomerId));
			Append(CreateParameter("PAN", adVarChar, adParamInput, 10, PAN));
		}
	}
	var rs = Solaren.Execute("ListContract");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Список договорiв")
}

var Header = ['Рахунок', 'Споживач', 'Адреса', 'Дата', 'ЦОС', 'Потужнiсть'],
ResponseText = ['<BODY CLASS="MainBody">',
	'<H3 CLASS="H3Text">' + Html.Title + '</H3>',
	'<TABLE CLASS="InfoTable">',
	Html.GetHeadRow(Header)
];

for (var i=totPwr=0; !rs.EOF; i++) {
	var ContractAddress = [Locality.Type[rs.Fields("LocalityType")],
		rs.Fields("LocalityName") + ",",
		Street.Type[rs.Fields("StreetType")],
		rs.Fields("StreetName"),
		rs.Fields("HouseId")
	],
	url = Html.GetLink("editcontract.asp?ContractId=", rs.Fields("ContractId"), rs.Fields("PAN")),
	td = [Tag.Write("TD", -1, url),
		Tag.Write("TD", 0, rs.Fields("CustomerName")),
		Tag.Write("TD", -1, ContractAddress.join(" ")),
		Tag.Write("TD", -1, rs.Fields("ContractDate")),
		Tag.Write("TD", -1, rs.Fields("BranchName")),
		Tag.Write("TD", 2, rs.Fields("ContractPower").value.toDelimited(1))
	],
	tr = Tag.Write("TR", -1, td.join(""));
	ResponseText.push(tr);
	totPwr += rs.Fields("ContractPower");
	rs.MoveNext();
}
rs.Close();
Solaren.Close();
var th = ['<TH ALIGN="LEFT" COLSPAN="5">Всього: ', i,'</TH>',
	Tag.Write("TH", 2, totPwr.toDelimited(1))
];
tr = Tag.Write("TR", -1, th.join(""));
ResponseText.push(tr);
ResponseText.push('</TABLE></BODY></HTML>');
Response.Write(ResponseText.join("\n"))%>
