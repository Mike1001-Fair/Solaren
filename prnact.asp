<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/money.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = User.RoleId == 2;
User.ValidateAccess(Authorized, "POST");

with (Request) {
	var ReportMonth = String(Form("ReportMonth")),
	ContractId      = Form("ContractId"),
	DoubleAct       = Form("DoubleAct") == "on";
}

try {
	Solaren.SetCmd("GetAct");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("ReportMonth", adVarChar, adParamInput, 10, ReportMonth));
			Append(CreateParameter("ContractId", adInteger, adParamInput, 10, ContractId));
		}
	}
	var rs = Solaren.Execute("GetAct", "Iнформацiю не знайдено");
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex));
} finally {
	with (rs) {
		var LocalityName = Fields("LocalityName").value,
		CompanyName  = Fields("CompanyName").value,
		BranchName   = Fields("BranchName").value,
		BranchName2  = Fields("BranchName2").value,

		CustomerName = Fields("CustomerName").value.replace(/ /g,"&nbsp"),
		ContractDate = Solaren.GetYMD(rs.Fields("ContractDate").value),
		ContractPAN  = Fields("ContractPAN").value,

		FactVol      = Fields("FactVol").value.toDelimited(0),
		VolCost      = Fields("VolCost").value.toDelimited(2),
		Pdfo         = Fields("Pdfo").value.toDelimited(2),
		Vz           = Fields("Vz").value.toDelimited(2),
		ActSum       = rs.Fields("ActSum").value,

		ChiefTitle   = Fields("ChiefTitle").value,
		ChiefName    = Fields("ChiefName").value,
		ChiefTitle2  = Fields("ChiefTitle2").value,
		ChiefName2   = Fields("ChiefName2").value.replace(/ /g,"&nbsp"),
		Accountant   = Fields("Accountant").value;
		Close();
	}
	Connect.Close();
	Html.SetHead("Акт приймання-передачi");
}

var Period   = Month.GetPeriod(ReportMonth, 1),
ActDate      = Month.GetLastDay(ReportMonth), 
WordSum      = Money.toWord(ActSum),
Body         = [],
Divider      = '\n<DIV CLASS="BlockDivider"></DIV>\n',
ResponseText = ['<BODY CLASS="ActContainer">'];

for (var i = 0; i <= DoubleAct; i++) {
	if (i == 0) {
		var block = ['<DIV CLASS="ActText">',
			'<H3 CLASS="H3PrnTable">Акт<SPAN>приймання-передачi електричної енергiї</SPAN></H3>',
			'<TABLE CLASS="NoBorderTable">',
			'<TR><TD ALIGN="LEFT" WIDTH="50%">' + LocalityName + '</TD><TD ALIGN="RIGHT" WIDTH="50%">' + ActDate + '</TD></TR>',
			'<TR><TD COLSPAN="2" STYLE="padding: 10px 0px">',
			'<P>Сторони по договору купiвлi-продажу електричної енергiї за "зеленим" тарифом приватним домогосподарством вiд ' +
			ContractDate.formatDate("-") + ' року, особовий рахунок №' + ContractPAN + ': ' +
			CompanyName + ' (Постачальник) в особi ' + ChiefTitle2 + ' ' + BranchName2 + ' ЦОС ' + ChiefName2 +
			', що дiє на пiдставi довiреностi, з однiєї сторони, та ' + CustomerName + ' (Споживач), з iншої сторони склали даний акт про наступне.</P>',
			'<P>У ' + Period + ' Споживачем передано, а Постачальником прийнято електричну енергiю (товар) в обсязi <B>' + FactVol + '</B> кВт&#183;год ' +
			'на суму <B>' + VolCost + '</B> грн., ПДФО <B>' + Pdfo + '</B> грн., вiйськовий збiр <B>' + Vz + '</B> грн., всього <B>' + ActSum.toDelimited(2) +
			'</B> грн. (' +	WordSum + '). Постачальник не має жодних претензiй до прийнятого ним товару.</P>',
			'<P>Цей акт складений у двох примiрниках - по одному для кожної зi сторiн, що його пiдписали.</P></TD></TR>',
			'<TR><TD>Постачальник:</TD><TD>Споживач:</TD></TR>',
			'<TR><TD STYLE="padding: 10px 0px 0px 0px">' + ChiefTitle + ' ' + ChiefName + '</TD><TD>' + CustomerName + '</TD></TR>',
			'<TR><TD><DIV CLASS="UnderLine"></DIV></TD><TD><DIV CLASS="UnderLine"></DIV></TD></TR></TABLE></DIV>'
		].join("\n");
	}
	Body.push(block);
}
ResponseText.push(Body.join(Divider));
ResponseText.push('</BODY></HTML>');
Response.Write(ResponseText.join("\n"))%>