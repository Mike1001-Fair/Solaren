<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/money.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->

<% var Authorized = User.RoleId == 2,
Form = Solaren.Parse(),
ReportMonth = String(Form.ReportMonth),
DoubleAct = Form.DoubleAct == "on";

User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("GetInfoAct");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
		}
	}	
	var rsInfo = Solaren.Execute("GetInfoAct", "Параметри не знайдено");

	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("ReportMonth", adVarChar, adParamInput, 10, ReportMonth));
		}
	}
	var rs = Solaren.Execute("SelectAct");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	var Record = Solaren.Map(rsInfo.Fields),
	Period  = Month.GetPeriod(ReportMonth, 1),
	ActDate = Month.GetLastDay(ReportMonth);
	Html.SetHead("Акт приймання-передачi");
	rsInfo.Close();
}

var Doc = {
	Body: [],
	Page: [],
	Divider: '\n<DIV CLASS="BlockDivider" STYLE="margin: 120px 0px 40px"></DIV>\n',
	PageBreak: '\n<SPAN CLASS="PageBreak"></SPAN>',

	Build: function(rs, DoubleAct) {
		for (; !rs.EOF; rs.MoveNext()) {
			this.ContractDate = Month.GetYMD(rs.Fields("ContractDate").Value),
			this.ContractPAN  = rs.Fields("ContractPAN"),
			this.CustomerName = rs.Fields("CustomerName").Value.replace(/ /g,"&nbsp"),
			this.ChiefName2   = Record.ChiefName2.replace(/ /g,"&nbsp"),
			this.Vz           = rs.Fields("Vz").Value.toDelimited(2),
			this.FactVol	  = rs.Fields("FactVol").Value.toDelimited(0),
			this.VolCost      = rs.Fields("VolCost").Value.toDelimited(2),
			this.Pdfo         = rs.Fields("Pdfo").Value.toDelimited(2),
			this.ActSum       = rs.Fields("ActSum").Value.toDelimited(2),
			this.WordSum      = Money.toWord(rs.Fields("ActSum").Value);
			this.Render(DoubleAct);
			if (this.Body.length == 2) {
				this.Page.push(this.Body.join(this.Divider));
				this.Body.length = 0;
			}
		}
		return this.Page.join(this.PageBreak)
	},

	Render: function(DoubleAct) {
		for (var i = 0; i <= DoubleAct; i++) {
			if (i == 0) {
				var block = ['<DIV CLASS="ActText">',
					'<H3 CLASS="H3PrnTable">Акт<SPAN>приймання-передачi електричної енергiї</SPAN></H3>',
					'<TABLE CLASS="NoBorderTable">',
					'<TR><TD ALIGN="LEFT" WIDTH="50%">' + Record.LocalityName + '</TD><TD ALIGN="RIGHT" WIDTH="50%">' + ActDate + '</TD></TR>',
					'<TR><TD COLSPAN="2" STYLE="padding: 10px 0px">',
					'<P>Сторони по договору купiвлi-продажу електричної енергiї за "зеленим" тарифом приватним домогосподарством вiд ' +
					this.ContractDate.formatDate("-") + ' року, особовий рахунок №' + this.ContractPAN + ': ' +
					Record.CompanyName + ' (Постачальник) в особi ' + Record.ChiefTitle2 + ' ' + Record.BranchName2 + ' ЦОС ' + Record.ChiefName2 +
					', що дiє на пiдставi довiреностi, з однiєї сторони, та ' + this.CustomerName + ' (Споживач), з iншої сторони склали даний акт про наступне.</P>',
					'<P>У ' + Period + ' Споживачем передано, а Постачальником прийнято електричну енергiю (товар) в обсязi <B>' + this.FactVol + '</B> кВт&#183;год ' +
					'на суму <B>' + this.VolCost + '</B> грн., ПДФО <B>' + this.Pdfo + '</B> грн., вiйськовий збiр <B>' + this.Vz + '</B> грн., всього <B>' + this.ActSum +
					'</B> грн. (' + this.WordSum + '). Постачальник не має жодних претензiй до прийнятого ним товару.</P>',
					'<P>Цей акт складений у двох примiрниках - по одному для кожної зi сторiн, що його пiдписали.</P></TD></TR>',
					'<TR><TD>Постачальник:</TD><TD>Споживач:</TD></TR>',
					'<TR><TD STYLE="padding: 10px 0px 0px 0px">' + Record.ChiefTitle + ' ' + Record.ChiefName + '</TD><TD>' + this.CustomerName + '</TD></TR>',
					'<TR><TD><DIV CLASS="UnderLine"></DIV></TD><TD><DIV CLASS="UnderLine"></DIV></TD></TR></TABLE></DIV>'
				].join("\n");
			}
			this.Body.push(block);
		}
	}
},
Output = ['\n<BODY CLASS="ActContainer">',
	Doc.Build(rs, DoubleAct),
	'</BODY></HTML>'
];

rs.Close();
Solaren.Close();
Response.Write(Output.join("\n"))%>
