<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/money.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->

<% var Authorized = User.RoleId == 2;
User.ValidateAccess(Authorized, "POST");

with (Request) {
	var ReportMonth = String(Form("ReportMonth")),
	DoubleAct       = Form("DoubleAct") == "on";
}

try {
	Solaren.SetCmd("GetInfoAct");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
		}
	}	
	var rsAct = Solaren.Execute("GetInfoAct", "Параметри не знайдено");

	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("ReportMonth", adVarChar, adParamInput, 10, ReportMonth));
		}
	}
	var rs = Solaren.Execute("SelectAct", "Iнформацiю не знайдено");

	with (rsAct) {
		var LocalityName = Fields("LocalityName").value,
		CompanyName      = Fields("CompanyName").value,
		BranchName       = Fields("BranchName").value,
		BranchName2      = Fields("BranchName2").value,
		ChiefTitle       = Fields("ChiefTitle").value,
		ChiefName        = Fields("ChiefName").value,
		ChiefTitle2      = Fields("ChiefTitle2").value,
		ChiefName2       = Fields("ChiefName2").value,
		Accountant       = Fields("Accountant").value;
		Close();
	}

} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

var Period   = Month.GetPeriod(ReportMonth, 1),
ActDate      = Month.GetLastDay(ReportMonth),
Divider      = '<DIV CLASS="BlockDivider" STYLE="margin: 120px 0px 40px"></DIV>\n',
PageBreak    = '<SPAN CLASS="PageBreak"></SPAN>\n',
Body         = [],
Page         = [],
ResponseText = ['<BODY CLASS="ActContainer">\n']; 

Html.SetHead("Акт приймання-передачi");

for (; !rs.EOF; rs.MoveNext()) {
	var Vz  = rs.Fields("Vz").value.toDelimited(2),
	FactVol	= rs.Fields("FactVol").value.toDelimited(0),
	VolCost = rs.Fields("VolCost").value.toDelimited(2),
	Pdfo    = rs.Fields("Pdfo").value.toDelimited(2),
	ActSum  = rs.Fields("ActSum").value.toDelimited(2),
	WordSum = Money.toWord(rs.Fields("ActSum").value),
	ChiefName2 = ChiefName2.replace(/ /g,"&nbsp"),
	CustomerName = rs.Fields("CustomerName").value.replace(/ /g,"&nbsp");

	for (var i=0; i<=DoubleAct; i++) {
		if (i == 0) {
			var block = ['<DIV CLASS="ActText">\n',
				'<H3 CLASS="H3PrnTable">Акт<SPAN>приймання-передачi електричної енергiї</SPAN></H3>\n',
				'<TABLE CLASS="NoBorderTable">\n',
				'<TR><TD ALIGN="LEFT" WIDTH="50%">' + LocalityName + '</TD><TD ALIGN="RIGHT" WIDTH="50%">' + ActDate + '</TD></TR>\n',
				'<TR><TD COLSPAN="2" STYLE="padding: 10px 0px">',
				'<P>Сторони по договору купiвлi-продажу електричної енергiї за "зеленим" тарифом приватним домогосподарством вiд ' + rs.Fields("ContractDate") + ' року, особовий рахунок №' + rs.Fields("ContractPAN") + ': ',
				CompanyName + ' (Постачальник) в особi ' + ChiefTitle2 + ' ' + BranchName2 + ' ЦОС ' + ChiefName2 + ', що дiє на пiдставi довiреностi, з однiєї сторони, та ' + CustomerName,
				' (Споживач), з iншої сторони склали даний акт про наступне.<P>\nУ '+ Period + ' Споживачем передано, а Постачальником прийнято електричну енергiю (товар) в обсязi <B>' + FactVol + '</B> кВт&#183;год на суму ',
				'<B>' + VolCost + '</B> грн., ПДФО <B>' + Pdfo + '</B> грн., вiйськовий збiр <B>' + Vz + '</B> грн., всього <B>' + ActSum + '</B> грн. (' + WordSum + ').\n',
				'Постачальник не має жодних претензiй до прийнятого ним товару.<P>Цей акт складений у двох примiрниках - по одному для кожної зi сторiн, що його пiдписали.</P></TD></TR>\n',
				'<TR><TD>Постачальник:</TD><TD>Споживач:</TD></TR>\n',
				'<TR><TD STYLE="padding: 10px 0px 0px 0px">' + BranchName + ' ЦОС<BR>' + ChiefTitle + ' ' + ChiefName + '</TD><TD>' + rs.Fields("CustomerName") + '</TD></TR>\n',
				'<TR><TD><DIV CLASS="UnderLine"></DIV></TD><TD><DIV CLASS="UnderLine"></DIV></TD></TR></TABLE></DIV>\n'
			].join("");
		}
		Body.push(block);
	}

	if (Body.length == 2) {
		Page.push(Body.join(Divider));
		Body.length = 0;
	}
}
rs.Close();
Connect.Close();
ResponseText.push(Page.join(PageBreak));
ResponseText.push('</BODY></HTML>');
Response.Write(ResponseText.join(""))%>