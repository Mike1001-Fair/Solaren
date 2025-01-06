<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/lib.inc" -->
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
	var rsNote = Solaren.Execute("GetNoteData", "Iнформацiю не знайдено");

	with (Cmd) {
		with (Parameters) {
			Delete("ChiefId");
			Append(CreateParameter("ReportMonth", adVarChar, adParamInput, 10, ReportMonth));
		}
	}
	var rs = Solaren.Execute("GetAllNote", "Iнформацiю не знайдено");
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex));
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
		TreasuryName    = Fields("TreasuryName").value,
		TreasuryCode    = Fields("TreasuryCode").value,
		TreasuryAccount = Fields("TreasuryAccount").value,
		TreasuryName    = Fields("TreasuryName").value,
		TreasuryMfo     = Fields("TreasuryMfo").value,
		ContractorName  = Fields("ContractorName").value,
		Phone           = Fields("Phone").value;
		Close();
	}
	Html.SetHead("Реєстр");
}

var Period = Month.GetPeriod(ReportMonth, 1),
PageBreak    = '<P CLASS="PageBreak"></P>\n',
Note         = [],
ResponseText = ['<BODY CLASS="PrnBody">\n'];

for (var n = 1; !rs.EOF; n++) {
	var totPurCost = 0, totVz = 0;
	block = ['<TABLE CLASS="NoBorderTable">\n',
		'<TR><TD>&nbsp</TD><TD ALIGN="LEFT" WIDTH="55%">' + TopChiefTitle3 + ' ' + CompanyName + '<BR>' + TopChiefName3 + '<BR>' + ChiefTitle2 + '<BR>' + ChiefName2 + '</TD></TR></TABLE>\n',
		'<H3 CLASS="H3PrnTable">Службовий лист №' + n + '</H3>\n',
		'<P>Прошу здiйснити оплату по договорам купiвлi-продажу електричної енергiї за "зеленим" тарифом приватним домогосподарством, згiдно актiв приймання-передачi електричної енергiї в ' + Period + '</P>\n',
		'<TABLE CLASS="PrnTable" WIDTH="100%">\n',
		'<TR><TH>Контрагент</TH><TH>Реквiзити</TH><TH>Призначення</TH><TH>Сума &#8372;</TH></TR>\n'
	];

	for (var i = 0; i < CustomerCount && !rs.EOF; i++) {
		var cardText = rs.Fields("CardId").value.length > 0 ? ". Для поп КР " : ".",
		customerInfo = [rs.Fields("CustomerName"), rs.Fields("ContractPAN")],
		details = [rs.Fields("CustomerCode").value.toDelimited(), 'Код МФО: ' + rs.Fields("MfoCode"), rs.Fields("BankAccount"), rs.Fields("BankName")],
		noteText = ['За вироблену електроенергію в ', Period, cardText, rs.Fields("CardId")],
		row = ['<TR>', Tag.Write("TD", -1,  customerInfo.join('<BR>')),
			Tag.Write("TD", -1, 'ІПН: ' + details.join('<BR>')),
			Tag.Write("TD", -1, noteText.join('')),
			Tag.Write("TD", 2, rs.Fields("PurCost").value.toDelimited(2)), '</TR>\n'
		];
		block.push(row.join(""));
		totPurCost += rs.Fields("PurCost").value;
		rs.MoveNext();		
	}

	var footer = ['</TABLE>\n',
		'<TABLE CLASS="NoBorderTable">\n' +
		'<TR><TD><B>Всього: ', totPurCost.toDelimited(2), '</B></TD>',
		'<TD ALIGN="RIGHT"><SUP>вик: ', ContractorName, ', 📞', Phone, '</SUP><DIV CLASS="UnderLine"></DIV></TD>',
		'</TR></TABLE>\n'
	];
	block.push(footer.join(""));
	Note.push(block.join(""));
}
rs.Close();
Connect.Close();
ResponseText.push(Note.join(PageBreak));
ResponseText.push('</BODY></HTML>');
Response.Write(ResponseText.join(""))%>