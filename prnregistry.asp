<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE VIRTUAL="Solaren/Set/list.set" -->
<% var Authorized = User.RoleId == 1,
Form = Webserver.Parse(),
ReportMonth = String(Form.ReportMonth);
User.CheckAccess(Authorized, "POST");

try {
	Db.SetCmd("GetNoteData");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adInteger, adParamInput, 10, User.Id));
			Append(CreateParameter("ChiefId", adInteger, adParamInput, 10, Form.ChiefId));
		}
	}
	var rsNote = Db.Execute("GetNoteData");

	with (Cmd) {
		with (Parameters) {
			Delete("ChiefId");
			Append(CreateParameter("ReportMonth", adVarChar, adParamInput, 10, ReportMonth));
		}
	}
	var rs = Db.Execute("GetAllNote");
} catch (ex) {
	Message.Write(3, Message.Error(ex));
} finally {
	var Record = Webserver.Map(rsNote.Fields),
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
				this.GetRows(rs, CustomerCount),
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

	GetRows: function(rs, CustomerCount) {
		var f = rs.Fields;
		for (var tr = []; tr.length < CustomerCount && !rs.EOF; rs.MoveNext()) {
			var cardText = f("CardId").Value.length > 0 ? ". Для поп КР " : ".",
			customerInfo = [f("CustomerName").Value, f("ContractPAN").Value],
			details = [f("CustomerCode").Value.toDelimited(), 'Код МФО: ' + f("MfoCode").Value, f("BankAccount").Value, f("BankName").Value],
			noteText = ['За вироблену електроенергію в ', Period, cardText, f("CardId").Value],
			row = ['<TR>', Tag.Write("TD", -1,  customerInfo.join('<BR>')),
				Tag.Write("TD", -1, 'ІПН: ' + details.join('<BR>')),
				Tag.Write("TD", -1, noteText.join('')),
				Tag.Write("TD", 2, f("PurCost").Value.toDelimited(2)), '</TR>'
			];
			tr.push(row.join(""));
			this.TotPurCost += f("PurCost").Value;			
		}
		return tr.join("\n")
	}
},
Output = ['\n<BODY CLASS="PrnBody">',
	Doc.Render(rs, Form.CustomerCount),
	'</BODY></HTML>'
];
rs.Close();
Db.Close();
Response.Write(Output.join("\n"))%>