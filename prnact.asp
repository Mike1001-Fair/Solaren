<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/money.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = User.RoleId == 2,
Form = Solaren.Map(Request.Form),
ReportMonth = String(Form.ReportMonth),
DoubleAct = Form.DoubleAct == "on";

User.ValidateAccess(Authorized, "POST");

try {
	Solaren.SetCmd("GetAct");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("ReportMonth", adVarChar, adParamInput, 10, ReportMonth));
			Append(CreateParameter("ContractId", adInteger, adParamInput, 10, Form.ContractId));
		}
	}
	var rs = Solaren.Execute("GetAct");
} catch (ex) {
	Message.Write(3, Message.Error(ex));
} finally {
	var Record = Solaren.Map(rs.Fields),
	Period = Month.GetPeriod(ReportMonth, 1),
	ActDate = Month.GetLastDay(ReportMonth),
	ResponseText = ['<BODY CLASS="ActContainer">'];
	Record.ContractDate = Month.GetYMD(Record.ContractDate);
	Record.CustomerName = Record.CustomerName.replace(/ /g,"&nbsp");
	Html.SetHead("Акт приймання-передачi");
}

var Doc = {
	Body: [],
	Divider: '<DIV CLASS="BlockDivider"></DIV>',

	Render: function(DoubleAct) {
		for (var i = 0; i <= DoubleAct; i++) {
			if (i == 0) {
				var FactVol = Record.FactVol.toDelimited(0),
				VolCost = Record.VolCost.toDelimited(2),
				Pdfo = Record.Pdfo.toDelimited(2),
				Vz = Record.Vz.toDelimited(2),
				ActSum = Record.ActSum.toDelimited(2),
				WordSum = Money.toWord(Record.ActSum),
				block = ['<DIV CLASS="ActText">',
					'<H3 CLASS="H3PrnTable">Акт<SPAN>приймання-передачi електричної енергiї</SPAN></H3>',
					'<TABLE CLASS="NoBorderTable">',
					'<TR><TD ALIGN="LEFT" WIDTH="50%">' + Record.LocalityName + '</TD><TD ALIGN="RIGHT" WIDTH="50%">' + ActDate + '</TD></TR>',
					'<TR><TD COLSPAN="2" STYLE="padding: 10px 0px">',
					'<P>Сторони по договору купiвлi-продажу електричної енергiї за "зеленим" тарифом приватним домогосподарством вiд ' +
					Record.ContractDate.formatDate("-") + ' року, особовий рахунок №' + Record.ContractPAN + ': ' +
					Record.CompanyName + ' (Постачальник) в особi ' + Record.ChiefTitle2 + ' ' + Record.BranchName2 + ' ЦОС ' + Record.ChiefName2 +
					', що дiє на пiдставi довiреностi, з однiєї сторони, та ' + Record.CustomerName + ' (Споживач), з iншої сторони склали даний акт про наступне.</P>',
					'<P>У ' + Period + ' Споживачем передано, а Постачальником прийнято електричну енергiю (товар) в обсязi <B>' + FactVol + '</B> кВт&#183;год ' +
					'на суму <B>' + VolCost + '</B> грн., ПДФО <B>' + Pdfo + '</B> грн., вiйськовий збiр <B>' + Vz +
					'</B> грн., всього <B>' + ActSum + '</B> грн. (' +	WordSum + '). Постачальник не має жодних претензiй до прийнятого ним товару.</P>',
					'<P>Цей акт складений у двох примiрниках - по одному для кожної зi сторiн, що його пiдписали.</P></TD></TR>',
					'<TR><TD>Постачальник:</TD><TD>Споживач:</TD></TR>',
					'<TR><TD STYLE="padding: 10px 0px 0px 0px">' + Record.ChiefTitle + ' ' + Record.ChiefName + '</TD><TD>' + Record.CustomerName + '</TD></TR>',
					'<TR><TD><DIV CLASS="UnderLine"></DIV></TD><TD><DIV CLASS="UnderLine"></DIV></TD></TR></TABLE></DIV>'
				].join("\n");
			}
			Doc.Body.push(block);
		}
		return Doc.Body.join(Doc.Divider)
	}
},
Output = Doc.Render(DoubleAct);

rs.Close();
Solaren.Close();
ResponseText.push(Output);
ResponseText.push('</BODY></HTML>');
Response.Write(ResponseText.join("\n"))%>