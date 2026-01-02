<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/list.set" -->
<% var Authorized = User.RoleId == 1;
User.CheckAccess(Authorized, "POST");

with (Request) {
    var BegDate = String(Form("BegDate")),
	EndDate = String(Form("EndDate"));
}

try {
	Solaren.SetCmd("ListSalesReport");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("BegDate", adVarChar, adParamInput, 10, BegDate));
			Append(CreateParameter("EndDate", adVarChar, adParamInput, 10, EndDate));
		}
	}
	var rs = Solaren.Execute("ListSalesReport");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Звіт")
}

var range = Month.GetRange(BegDate, EndDate),
totalQuantity = 0,
Output = ['<BODY CLASS="MainBody">',
	'<H3 CLASS="H3Text">Звіт<SPAN>Період: ' + range + '</SPAN></H3>',
	'<TABLE CLASS="InfoTable">',
	'<TR><TH>Назва</TH><TH>Кількість</TH></TR>'
];

for (var i=0; !rs.EOF; i++) {
	var td = [Tag.Write("TD", -1, rs.Fields("ItemName")),
		Tag.Write("TD", 2, rs.Fields("Quantity"))
	],
	tr = Tag.Write("TR", -1, td.join(""));
	Output.push(tr);
	totalQuantity += rs.Fields("Quantity").Value;
	rs.MoveNext();
}
rs.Close();
Solaren.Close();
Output.push(Html.GetFooterRow(2, i));
Response.Write(Output.join("\n"))%>


