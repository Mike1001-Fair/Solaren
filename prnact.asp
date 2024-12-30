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

			Append(CreateParameter("LocalityName", adVarChar, adParamOutput, 30, ""));
			Append(CreateParameter("CompanyName", adVarChar, adParamOutput, 50, ""));
			Append(CreateParameter("BranchName", adVarChar, adParamOutput, 50, ""));
			Append(CreateParameter("BranchName2", adVarChar, adParamOutput, 50, ""));

			Append(CreateParameter("CustomerName", adVarChar, adParamOutput, 50, ""));
			Append(CreateParameter("ContractDate", adVarChar, adParamOutput, 10, ""));
			Append(CreateParameter("ContractPAN", adVarChar, adParamOutput, 10, ""));

			Append(CreateParameter("FactVol", adInteger, adParamOutput, 16, 0));
			Append(CreateParameter("VolCost", adCurrency, adParamOutput, 16, 0));
			Append(CreateParameter("Pdfo", adCurrency, adParamOutput, 16, 0));
			Append(CreateParameter("Vz", adCurrency, adParamOutput, 16, 0));

			Append(CreateParameter("ChiefTitle", adVarChar, adParamOutput, 50, ""));
			Append(CreateParameter("ChiefName", adVarChar, adParamOutput, 50, ""));
			Append(CreateParameter("ChiefTitle2", adVarChar, adParamOutput, 50, ""));
			Append(CreateParameter("ChiefName2", adVarChar, adParamOutput, 50, ""));
			Append(CreateParameter("Accountant", adVarChar, adParamOutput, 50, ""));
		} Execute(adExecuteNoRecords);

		with (Parameters) {
			var LocalityName = Item("LocalityName").value,
			CompanyName  = Item("CompanyName").value,
			BranchName   = Item("BranchName").value,
			BranchName2  = Item("BranchName2").value,

			CustomerName = Item("CustomerName").value,
			ContractDate = Item("ContractDate").value,
			ContractPAN  = Item("ContractPAN").value,

			FactVol      = Item("FactVol").value,
			VolCost      = Item("VolCost").value,
			Pdfo         = Item("Pdfo").value,
			Vz           = Item("Vz").value,

			ChiefTitle   = Item("ChiefTitle").value,
			ChiefName    = Item("ChiefName").value,
			ChiefTitle2  = Item("ChiefTitle2").value,
			ChiefName2   = Item("ChiefName2").value,
			Accountant   = Item("Accountant").value;
		}
	}
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex));
} finally {	
	Connect.Close();
	if (Solaren.Empty(VolCost)) {
		Solaren.SysMsg(0, "Інформацію не знайдено")
	} else {
		Html.SetHead("Акт приймання-передачi");
	}
}

var Period   = Month.GetPeriod(ReportMonth, 1),
ActDate      = Month.GetLastDay(ReportMonth), 
ActSum       = VolCost - Pdfo - Vz,
WordSum      = Money.toWord(ActSum),
Body         = [],
Divider      = DoubleAct ? '<DIV CLASS="BlockDivider"></DIV>\n' : '',
ResponseText = ['<BODY CLASS="ActContainer">\n']; 

for (var i=0; i<=DoubleAct; i++) {
	if (i == 0) {
		var block = ['<DIV CLASS="ActText">\n',
			'<H3 CLASS="H3PrnTable">Акт<SPAN>приймання-передачi електричної енергiї</SPAN></H3>\n',
			'<TABLE CLASS="NoBorderTable">\n',
			'<TR><TD ALIGN="LEFT" WIDTH="50%">' + LocalityName + '</TD><TD ALIGN="RIGHT" WIDTH="50%">' + ActDate + '</TD></TR>\n',
			'<TR><TD COLSPAN="2" STYLE="padding: 10px 0px">',
			'<P>Сторони по договору купiвлi-продажу електричної енергiї за "зеленим" тарифом приватним домогосподарством вiд ' + ContractDate + ' року, особовий рахунок №' + ContractPAN + ': ',
			CompanyName + ' (Постачальник) в особi ' + ChiefTitle2 + ' ' + BranchName2 + ' ЦОС ' + ChiefName2.replace(/ /g,"&nbsp") + ', що дiє на пiдставi довiреностi, з однiєї сторони, та ',
			CustomerName.replace(/ /g,"&nbsp") + ' (Споживач), з iншої сторони склали даний акт про наступне.',
			'<P>\nУ ' + Period + ' Споживачем передано, а Постачальником прийнято електричну енергiю (товар) в обсязi <B>' + FactVol.toDelimited(0) + '</B> кВт&#183;год ',
			'на суму <B>' + VolCost.toDelimited(2) + '</B> грн., ПДФО <B>' + Pdfo.toDelimited(2) + '</B> грн., вiйськовий збiр <B>' + Vz.toDelimited(2) + '</B> грн., всього <B>' + ActSum.toDelimited(2) + '</B> грн. (' + WordSum + '). ',
			'Постачальник не має жодних претензiй до прийнятого ним товару.',
			'<P>Цей акт складений у двох примiрниках - по одному для кожної зi сторiн, що його пiдписали.</P></TD></TR>',
			'<TR ALIGN="CENTER"><TD>Постачальник:</TD><TD>Споживач:</TD></TR>\n',
			'<TR ALIGN="CENTER"><TD STYLE="padding: 10px 0px 0px 0px">' + ChiefTitle + ' ' + ChiefName + '</TD><TD>' + CustomerName + '</TD></TR>\n',
			'<TR ALIGN="CENTER"><TD><DIV CLASS="UnderLine"></DIV></TD><TD><DIV CLASS="UnderLine"></DIV></TD></TR></TABLE></DIV>\n'			
		].join("");
	}
	Body.push(block);
}
ResponseText.push(Body.join(Divider));
ResponseText.push('</BODY></HTML>');
Response.Write(ResponseText.join(""))%>