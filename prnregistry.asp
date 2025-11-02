<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = User.RoleId == 1,
Form = Solaren.Parse(),
ReportMonth = String(Form.ReportMonth);
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("GetNoteData");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adInteger, adParamInput, 10, User.Id));
			Append(CreateParameter("ChiefId", adInteger, adParamInput, 10, Form.ChiefId));
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
	var Record = Solaren.Map(rsNote.Fields),
	Period = Month.GetPeriod(ReportMonth, 1);
	rsNote.Close();
	Html.SetHead("Реєстр");
}

var Doc = {
	Body: [],
	TotPurCost: 0,

	Render: function(rs, CustomerCount) {
		var Header = ['Контрагент', 'Реквiзити', 'Призначення', 'Сума &#8372;'],
		TopTitle = [Record.TopChiefTitle3, Record.CompanyName, Record.TopChiefName3, Record.ChiefTitle2, Record.ChiefName2],
		PageBreak = '\n<P CLASS="PageBreak"></P>\n';

		for (var n = 1; !rs.EOF; n++) {
			var Note = ['<TABLE CLASS="NoBorderTable">',
				'<TR><TD>&nbsp</TD><TD ALIGN="LEFT" WIDTH="55%">' + TopTitle.join('<BR>') + '</TD></TR></TABLE>',
				'<H3 CLASS="H3PrnTable">Службовий лист №' + n + '</H3>',
				'<P>Прошу здiйснити оплату по договорам купiвлi-продажу електричної енергiї за "зеленим" тарифом приватним домогосподарством, згiдно актiв приймання-передачi електричної енергiї в ' + Period + '</P>',
				'<TABLE CLASS="PrnTable" WIDTH="100%">',
				Html.GetHeadRow(Header),
				this.GetRows(CustomerCount),
				'</TABLE>',
				'<TABLE CLASS="NoBorderTable">',
				'<TR><TD><B>Всього: ' + this.TotPurCost.toDelimited(2) + '</B></TD>',
				'<TD ALIGN="RIGHT"><SUP>вик: ' + Record.ContractorName + ', 📞' + Record.Phone + '</SUP><DIV CLASS="UnderLine"></DIV></TD>',
				'</TR></TABLE>'
			];
			this.Body.push(Note.join("\n"));
			this.TotPurCost = 0;
		}
		return this.Body.join(PageBreak)
	},

	GetRows: function(CustomerCount) {
		for (var tr = []; tr.length < CustomerCount && !rs.EOF; rs.MoveNext()) {
			var cardText = rs.Fields("CardId").Value.length > 0 ? ". Для поп КР " : ".",
			customerInfo = [rs.Fields("CustomerName"), rs.Fields("ContractPAN")],
			details = [rs.Fields("CustomerCode").Value.toDelimited(), 'Код МФО: ' + rs.Fields("MfoCode"), rs.Fields("BankAccount"), rs.Fields("BankName")],
			noteText = ['За вироблену електроенергію в ', Period, cardText, rs.Fields("CardId")],
			row = ['<TR>', Tag.Write("TD", -1,  customerInfo.join('<BR>')),
				Tag.Write("TD", -1, 'ІПН: ' + details.join('<BR>')),
				Tag.Write("TD", -1, noteText.join('')),
				Tag.Write("TD", 2, rs.Fields("PurCost").Value.toDelimited(2)), '</TR>'
			];
			tr.push(row.join(""));
			this.TotPurCost += rs.Fields("PurCost").Value;			
		}
		return tr.join("\n")
	}
},
Output = ['\n<BODY CLASS="PrnBody">',
	Doc.Render(rs, Form.CustomerCount),
	'</BODY></HTML>'
];
rs.Close();
Solaren.Close();
Response.Write(Output.join("\n"))%>