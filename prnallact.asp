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
Form = Solaren.Map(Request.Form);
Form.ReportMonth = String(Form.ReportMonth);
Form.DoubleAct = Form.DoubleAct == "on";
User.ValidateAccess(Authorized, "POST");

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
			Append(CreateParameter("ReportMonth", adVarChar, adParamInput, 10, Form.ReportMonth));
		}
	}
	var rs = Solaren.Execute("SelectAct");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	var Record = Solaren.Map(rsInfo.Fields),
	Period  = Month.GetPeriod(Form.ReportMonth, 1),
	ActDate = Month.GetLastDay(Form.ReportMonth),
	Divider = '\n<DIV CLASS="BlockDivider" STYLE="margin: 120px 0px 40px"></DIV>\n',
	PageBreak = '\n<SPAN CLASS="PageBreak"></SPAN>',
	Body = [],
	Page = [],
	ResponseText = ['<BODY CLASS="ActContainer">']; 
	Html.SetHead("Акт приймання-передачi");
}

for (; !rs.EOF; rs.MoveNext()) {
	var ContractDate = Month.GetYMD(rs.Fields("ContractDate").value),
	ContractPAN = rs.Fields("ContractPAN"),
	CustomerName = rs.Fields("CustomerName").value.replace(/ /g,"&nbsp"),
	ChiefName2 = Record.ChiefName2.replace(/ /g,"&nbsp"),
	Vz      = rs.Fields("Vz").value.toDelimited(2),
	FactVol	= rs.Fields("FactVol").value.toDelimited(0),
	VolCost = rs.Fields("VolCost").value.toDelimited(2),
	Pdfo    = rs.Fields("Pdfo").value.toDelimited(2),
	ActSum  = rs.Fields("ActSum").value.toDelimited(2),
	WordSum = Money.toWord(rs.Fields("ActSum").value);

	for (var i = 0; i <= Form.DoubleAct; i++) {
		if (i == 0) {
			var block = ['<DIV CLASS="ActText">',
				'<H3 CLASS="H3PrnTable">Акт<SPAN>приймання-передачi електричної енергiї</SPAN></H3>',
				'<TABLE CLASS="NoBorderTable">',
				'<TR><TD ALIGN="LEFT" WIDTH="50%">' + Record.LocalityName + '</TD><TD ALIGN="RIGHT" WIDTH="50%">' + ActDate + '</TD></TR>',
				'<TR><TD COLSPAN="2" STYLE="padding: 10px 0px">',
				'<P>Сторони по договору купiвлi-продажу електричної енергiї за "зеленим" тарифом приватним домогосподарством вiд ' +
				ContractDate.formatDate("-") + ' року, особовий рахунок №' + ContractPAN + ': ' +
				Record.CompanyName + ' (Постачальник) в особi ' + Record.ChiefTitle2 + ' ' + Record.BranchName2 + ' ЦОС ' + Record.ChiefName2 +
				', що дiє на пiдставi довiреностi, з однiєї сторони, та ' + CustomerName + ' (Споживач), з iншої сторони склали даний акт про наступне.</P>',
				'<P>У ' + Period + ' Споживачем передано, а Постачальником прийнято електричну енергiю (товар) в обсязi <B>' + FactVol + '</B> кВт&#183;год ' +
				'на суму <B>' + VolCost + '</B> грн., ПДФО <B>' + Pdfo + '</B> грн., вiйськовий збiр <B>' + Vz + '</B> грн., всього <B>' + ActSum +
				'</B> грн. (' + WordSum + '). Постачальник не має жодних претензiй до прийнятого ним товару.</P>',
				'<P>Цей акт складений у двох примiрниках - по одному для кожної зi сторiн, що його пiдписали.</P></TD></TR>',
				'<TR><TD>Постачальник:</TD><TD>Споживач:</TD></TR>',
				'<TR><TD STYLE="padding: 10px 0px 0px 0px">' + Record.ChiefTitle + ' ' + Record.ChiefName + '</TD><TD>' + CustomerName + '</TD></TR>',
				'<TR><TD><DIV CLASS="UnderLine"></DIV></TD><TD><DIV CLASS="UnderLine"></DIV></TD></TR></TABLE></DIV>'
			].join("\n");
		}
		Body.push(block);
	}

	if (Body.length == 2) {
		Page.push(Body.join(Divider));
		Body.length = 0;
	}
}
rs.Close();
Solaren.Close();
ResponseText.push(Page.join(PageBreak));
ResponseText.push('</BODY></HTML>');
Response.Write(ResponseText.join("\n"))%>
