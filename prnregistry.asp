<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = User.RoleId == 1;
User.ValidateAccess(Authorized, "POST");

with (Request) {
	var ReportMonth = String(Form("ReportMonth")),
	CustomerCount   = Form("CustomerCount"),
	ChiefId         = Form("ChiefId");
}

try {
	Solaren.SetCmd("GetNoteData");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adInteger, adParamInput, 10, User.Id));
			Append(CreateParameter("ChiefId", adInteger, adParamInput, 10, ChiefId));
		}
	}
	var rsNote = Solaren.Execute("GetNoteData");

	with (Cmd) {
		with (Parameters) {
			Delete("ChiefId");
			Append(CreateParameter("ReportMonth", adVarChar, adParamInput, 10, ReportMonth));
		}
	}
	var rs = Solaren.Execute("GetAllNote");
} catch (ex) {
	Message.Write(3, Message.Error(ex));
} finally {
	with (rsNote) {
		var CompanyCode = Fields("CompanyCode").value,
		CompanyName     = Fields("CompanyName").value,
		TopChiefTitle3  = Fields("TopChiefTitle3").value,
		TopChiefName3   = Fields("TopChiefName3").value,
		ChiefTitle      = Fields("ChiefTitle").value,
		ChiefName       = Fields("ChiefName").value,
		ChiefTitle2     = Fields("ChiefTitle2").value,
		ChiefName2      = Fields("ChiefName2").value,
		ContractorName  = Fields("ContractorName").value,
		Phone           = Fields("Phone").value;
		Close();
	}
	Html.SetHead("Реєстр");
}

var Note = [],
Header   = ['Контрагент', 'Реквiзити', 'Призначення', 'Сума &#8372;'],
TopTitle = [TopChiefTitle3, CompanyName, TopChiefName3, ChiefTitle2, ChiefName2],
Period   = Month.GetPeriod(ReportMonth, 1),
PageBreak = '<P CLASS="PageBreak"></P>',
ResponseText = ['<BODY CLASS="PrnBody">'];

for (var n = 1; !rs.EOF; n++) {
	var totPurCost = 0,
	block = ['\n<TABLE CLASS="NoBorderTable">',
		'<TR><TD>&nbsp</TD><TD ALIGN="LEFT" WIDTH="55%">' + TopTitle.join('<BR>') + '</TD></TR></TABLE>',
		'<H3 CLASS="H3PrnTable">Службовий лист №' + n + '</H3>',
		'<P>Прошу здiйснити оплату по договорам купiвлi-продажу електричної енергiї за "зеленим" тарифом приватним домогосподарством, згiдно актiв приймання-передачi електричної енергiї в ' + Period + '</P>',
		'<TABLE CLASS="PrnTable" WIDTH="100%">',
		Html.GetHeadRow(Header)
	];

	for (var i = 0; i < CustomerCount && !rs.EOF; i++) {
		var cardText = rs.Fields("CardId").value.length > 0 ? ". Для поп КР " : ".",
		customerInfo = [rs.Fields("CustomerName"), rs.Fields("ContractPAN")],
		details = [rs.Fields("CustomerCode").value.toDelimited(), 'Код МФО: ' + rs.Fields("MfoCode"), rs.Fields("BankAccount"), rs.Fields("BankName")],
		noteText = ['За вироблену електроенергію в ', Period, cardText, rs.Fields("CardId")],
		row = ['<TR>', Tag.Write("TD", -1,  customerInfo.join('<BR>')),
			Tag.Write("TD", -1, 'ІПН: ' + details.join('<BR>')),
			Tag.Write("TD", -1, noteText.join('')),
			Tag.Write("TD", 2, rs.Fields("PurCost").value.toDelimited(2)), '</TR>'
		];
		block.push(row.join(""));
		totPurCost += rs.Fields("PurCost").value;
		rs.MoveNext();		
	}

	var footer = ['</TABLE>',
		'<TABLE CLASS="NoBorderTable">',
		'<TR><TD><B>Всього: ' + totPurCost.toDelimited(2) + '</B></TD>',
		'<TD ALIGN="RIGHT"><SUP>вик: ' + ContractorName + ', 📞' + Phone + '</SUP><DIV CLASS="UnderLine"></DIV></TD>',
		'</TR></TABLE>'
	];
	block.push(footer.join("\n"));
	Note.push(block.join("\n"));
}
rs.Close();
Solaren.Close();
ResponseText.push(Note.join(PageBreak));
ResponseText.push('</BODY></HTML>');
Response.Write(ResponseText.join("\n"))%>

