<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Include/list.inc" -->
<% var Authorized = User.RoleId == 1;
User.CheckAccess(Authorized, "POST");

with (Request) {
	var BegDate = String(Form("BegDate")),
	EndDate     = String(Form("EndDate")),
	ContractId  = Form("ContractId"),
	Deleted     = Form("Deleted") == "on";
}

try {
	Solaren.SetCmd("ListOrder");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("BegDate", adVarChar, adParamInput, 10, BegDate));
			Append(CreateParameter("EndDate", adVarChar, adParamInput, 10, EndDate));
			Append(CreateParameter("ContractId", adVarChar, adParamInput, 10, ContractId));
			Append(CreateParameter("Deleted", adBoolean, adParamInput, 1, Deleted));
		}
	}
	//var rs = Solaren.Execute("ListOrder");
	var rs = Solaren.Execute("ListOrder");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Список замовлень");
}

var Period = BegDate.formatDate("-"),
EndDate    = EndDate.formatDate("-");

if (Period != EndDate) Period += ' &ndash; ' + EndDate;

var Output = ['<BODY CLASS="MainBody">',
	'<H3 CLASS="H3Text">Список замовлень<SPAN>Період: ' + Period + '</SPAN></H3>',
	'<TABLE CLASS="InfoTable">',
	'<TR><TH>№</TH><TH>Дaта</TH><TH>Споживач</TH><TH>Рахунок</TH></TR>'
];

for (var i=0; !rs.EOF; i++) {
	var url = ['<A HREF="editorder.asp?OrderId=', rs.Fields("OrderId"), '">', rs.Fields("OrderId"), '</A>'],
	row = ['<TR>', Tag.Write("TD", -1, url.join("")),
		Tag.Write("TD", -1, rs.Fields("OrderDate")),
		Tag.Write("TD", -1, rs.Fields("CustomerName")),
		Tag.Write("TD", -1, rs.Fields("ContractPAN")), '</TR>'
	];
	Output.push(row.join(""));
	rs.MoveNext();
} rs.Close();
Solaren.Close();
Output.push(Html.GetFooterRow(4, i));
Response.Write(Output.join("\n"))%>


