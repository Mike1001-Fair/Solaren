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
		ContractDate = Fields("ContractDate").value,
		ContractPAN  = Fields("ContractPAN").value,

		FactVol      = Fields("FactVol").value,
		VolCost      = Fields("VolCost").value,
		Pdfo         = Fields("Pdfo").value,
		Vz           = Fields("Vz").value,

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
ActSum       = VolCost - Pdfo - Vz,
WordSum      = Money.toWord(ActSum),
Body         = [],
Divider      = '<DIV CLASS="BlockDivider"></DIV>\n',
ResponseText = ['<BODY CLASS="ActContainer">\n'];

for (var i=0; i<=DoubleAct; i++) {
	if (i == 0) {
		var block = ['<DIV CLASS="ActText">\n',
			'<H3 CLASS="H3PrnTable">Акт<SPAN>приймання-передачi електричної енергiї</SPAN></H3>\n',
			'<TABLE CLASS="NoBorderTable">\n',
			'<TR><TD ALIGN="LEFT" WIDTH="50%">' + LocalityName + '</TD><TD ALIGN="RIGHT" WIDTH="50%">' + ActDate + '</TD></TR>\n',
			'<TR><TD COLSPAN="2" STYLE="padding: 10px 0px">',
			'<P>Сторони по договору купiвлi-продажу електричної енергiї за "зеленим" тарифом приватним домогосподарством вiд ' + ContractDate + ' року, особовий рахунок №' + ContractPAN + ': ',
			CompanyName + ' (Постачальник) в особi ' + ChiefTitle2 + ' ' + BranchName2 + ' ЦОС ' + ChiefName2 + ', що дiє на пiдставi довiреностi, з однiєї сторони, та ',
			CustomerName + ' (Споживач), з iншої сторони склали даний акт про наступне.',
			'<P>\nУ ' + Period + ' Споживачем передано, а Постачальником прийнято електричну енергiю (товар) в обсязi <B>' + FactVol.toDelimited(0) + '</B> кВт&#183;год ',
			'на суму <B>' + VolCost.toDelimited(2) + '</B> грн., ПДФО <B>' + Pdfo.toDelimited(2) + '</B> грн., вiйськовий збiр <B>' + Vz.toDelimited(2) + '</B> грн., всього <B>' + ActSum.toDelimited(2) + '</B> грн. (' + WordSum + '). ',
			'Постачальник не має жодних претензiй до прийнятого ним товару.',
			'<P>Цей акт складений у двох примiрниках - по одному для кожної зi сторiн, що його пiдписали.</P></TD></TR>',
			'<TR><TD>Постачальник:</TD><TD>Споживач:</TD></TR>\n',
			'<TR><TD STYLE="padding: 10px 0px 0px 0px">' + ChiefTitle + ' ' + ChiefName + '</TD><TD>' + CustomerName + '</TD></TR>\n',
			'<TR><TD><DIV CLASS="UnderLine"></DIV></TD><TD><DIV CLASS="UnderLine"></DIV></TD></TR></TABLE></DIV>\n'
		].join("");
	}
	Body.push(block);
}
ResponseText.push(Body.join(Divider));
ResponseText.push('</BODY></HTML>');
Response.Write(ResponseText.join(""))%>