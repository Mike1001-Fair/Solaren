<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/money.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
	var ReportMonth = String(Form("ReportMonth")),
	CustomerCount   = Form("CustomerCount"),
	ChiefId         = Form("ChiefId");
}

try {
	Solaren.SetCmd("GetNoteData");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adInteger, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("ChiefId", adInteger, adParamInput, 10, ChiefId));
			Append(CreateParameter("CompanyCode", adVarChar, adParamOutput, 10, ""));
			Append(CreateParameter("CompanyName", adVarChar, adParamOutput, 50, ""));
			Append(CreateParameter("TopChiefTitle3", adVarChar, adParamOutput, 50, ""));
			Append(CreateParameter("TopChiefName3", adVarChar, adParamOutput, 50, ""));
			Append(CreateParameter("ChiefTitle", adVarChar, adParamOutput, 50, ""));
			Append(CreateParameter("ChiefName", adVarChar, adParamOutput, 50, ""));
			Append(CreateParameter("ChiefTitle2", adVarChar, adParamOutput, 50, ""));
			Append(CreateParameter("ChiefName2", adVarChar, adParamOutput, 50, ""));
			Append(CreateParameter("TreasuryName", adVarChar, adParamOutput, 50, ""));
			Append(CreateParameter("TreasuryCode", adVarChar, adParamOutput, 10, ""));
			Append(CreateParameter("TreasuryAccount", adVarChar, adParamOutput, 30, ""));
 			Append(CreateParameter("TreasuryMfo", adVarChar, adParamOutput, 10, ""));
			Append(CreateParameter("ContractorName", adVarChar, adParamOutput, 20, ""));
			Append(CreateParameter("Phone", adVarChar, adParamOutput, 10, ""));
		} Execute(adExecuteNoRecords);
	}
	with (Cmd.Parameters) {
		var ChiefId     = Item("ChiefId").value,
		CompanyCode     = Item("CompanyCode").value,
		CompanyName     = Item("CompanyName").value,
		TopChiefTitle3  = Item("TopChiefTitle3").value,
		TopChiefName3   = Item("TopChiefName3").value,
		ChiefTitle      = Item("ChiefTitle").value,
		ChiefName       = Item("ChiefName").value,
		ChiefTitle2     = Item("ChiefTitle2").value,
		ChiefName2      = Item("ChiefName2").value,
		TreasuryName    = Item("TreasuryName").value,
		TreasuryCode    = Item("TreasuryCode").value,
		TreasuryAccount = Item("TreasuryAccount").value,
		TreasuryName    = Item("TreasuryName").value,
		TreasuryMfo     = Item("TreasuryMfo").value,
		ContractorName  = Item("ContractorName").value,
		Phone           = Item("Phone").value;
	}
	with (Cmd) {
		CommandText = "GetAllNote";
		with (Parameters) {
			while (Count > 0) { Delete(0) };
			Append(CreateParameter("UserId", adInteger, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("ReportMonth", adVarChar, adParamInput, 10, ReportMonth));
		}
	}
	var rs = Cmd.Execute(); 
	Solaren.EOF(rs, 'Iнформацiю не знайдено');
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex));
}

var Period = Month.GetPeriod(ReportMonth, 1),
ResponseText = '<BODY CLASS="PrnBody">\n';

Html.SetHead("Реєстр");
for (var n=1; !rs.EOF; n++) {
	var totPurCost = 0, totVz = 0;
	ResponseText += '<TABLE CLASS="NoBorderTable">\n' +
	'<TR><TD>&nbsp</TD><TD ALIGN="LEFT" WIDTH="55%">' + TopChiefTitle3 + ' ' + CompanyName + '<BR>' + TopChiefName3 + '<BR>' + ChiefTitle2 + '<BR>' + ChiefName2 + '</TD></TR></TABLE>\n' +
	'<H3 CLASS="H3PrnTable">Службовий лист №' + n + '</H3>\n' +
	'<P>Прошу здiйснити оплату по договорам купiвлi-продажу електричної енергiї за "зеленим" тарифом приватним домогосподарством, згiдно актiв приймання-передачi електричної енергiї в ' + Period + '</P>\n' +
	'<TABLE CLASS="PrnTable" WIDTH="100%">\n' +
	'<TR><TH>Контрагент</TH><TH>Реквiзити</TH><TH>Призначення</TH><TH>Сума &#8372;</TH></TR>\n';

	for (var i=0; i<CustomerCount && !rs.EOF; i++) {
		var note = rs.Fields("CardId").value.length > 0 ? ". Для поп КР " : ".";
		ResponseText += '<TR><TD>' + rs.Fields("CustomerName") + '<BR>' + rs.Fields("ContractPAN") +
		Html.Write("TD", "") + 'ІПН: ' + rs.Fields("CustomerCode").value.toDelimited() + '<BR>Код МФО: ' + rs.Fields("MfoCode") + '<BR>' + rs.Fields("BankAccount") + '<BR>' + rs.Fields("BankName") +
		Html.Write("TD", "") + 'За вироблену електроенергію в ' + Period  + note + rs.Fields("CardId") +
		Html.Write("TD", "RIGHT") + rs.Fields("PurCost").value.toDelimited(2) + '</TD></TR>\n'
		totPurCost += rs.Fields("PurCost").value;
		rs.MoveNext();		
	}
	ResponseText +=	'</TABLE>\n' +
	'<TABLE CLASS="NoBorderTable">\n' +
	'<TR><TD><B>Всього: ' + totPurCost.toDelimited(2) + '</B></TD>' + 
	'<TD ALIGN="RIGHT"><SUP>вик: ' + ContractorName + ', 📞' + Phone + '</SUP><DIV CLASS="UnderLine"></DIV></TD></TR></TABLE>\n';
	if (!rs.EOF) {
		ResponseText += '<P CLASS="PageBreak"></P>\n';
	}
}
ResponseText += '</BODY></HTML>';
Response.Write(ResponseText);
rs.Close();Connect.Close()%>