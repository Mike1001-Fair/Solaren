<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/list.set" -->
<% var Authorized = User.RoleId == 1,
Form = Solaren.Parse(),
ReportMonth = String(Form.ReportMonth);
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("GetNote");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adInteger, adParamInput, 10, User.Id));
			Append(CreateParameter("ReportMonth", adVarChar, adParamInput, 10, ReportMonth));
			Append(CreateParameter("ContractId", adInteger, adParamInput, 10, Form.ContractId));

			Append(CreateParameter("ChiefId", adVarChar, adParamInput, 10, Form.ChiefId));
			Append(CreateParameter("CompanyCode", adVarChar, adParamOutput, 10, ""));
			Append(CreateParameter("CompanyName", adVarChar, adParamOutput, 50, ""));

			Append(CreateParameter("CustomerCode", adVarChar, adParamOutput, 10, ""));
			Append(CreateParameter("CustomerName", adVarChar, adParamOutput, 50, ""));
			Append(CreateParameter("CardId", adVarChar, adParamOutput, 20, 0));
			Append(CreateParameter("BankId", adInteger, adParamOutput, 10, 0));
			Append(CreateParameter("BankAccount", adVarChar, adParamOutput, 30, 0));

			Append(CreateParameter("EdrpoBank", adVarChar, adParamOutput, 10, ""));
			Append(CreateParameter("MfoCode", adVarChar, adParamOutput, 10, ""));
			Append(CreateParameter("BankName", adVarChar, adParamOutput, 50, ""));

			Append(CreateParameter("ContractPAN", adVarChar, adParamOutput, 10, 0));
			Append(CreateParameter("ContractDate", adVarChar, adParamOutput, 10, ""));

			Append(CreateParameter("PurCost", adCurrency, adParamOutput, 16, 0));
			Append(CreateParameter("Pdfo", adCurrency, adParamOutput, 16, 0));
			Append(CreateParameter("Vz", adCurrency, adParamOutput, 16, 0));

	        Append(CreateParameter("TreasuryName", adVarChar, adParamOutput, 50, ""));
	        Append(CreateParameter("TreasuryCode", adVarChar, adParamOutput, 10, ""));
	        Append(CreateParameter("TreasuryAccount", adVarChar, adParamOutput, 30, ""));
	        Append(CreateParameter("TreasuryMfo", adVarChar, adParamOutput, 10, ""));

			Append(CreateParameter("TopChiefTitle3", adVarChar, adParamOutput, 50, ""));
			Append(CreateParameter("TopChiefName3", adVarChar, adParamOutput, 50, ""));
			Append(CreateParameter("ChiefTitle", adVarChar, adParamOutput, 50, ""));
			Append(CreateParameter("ChiefName", adVarChar, adParamOutput, 50, ""));
			Append(CreateParameter("ChiefTitle2", adVarChar, adParamOutput, 50, ""));
			Append(CreateParameter("ChiefName2", adVarChar, adParamOutput, 50, ""));
			Append(CreateParameter("ContractorName", adVarChar, adParamOutput, 20, ""));
			Append(CreateParameter("Phone", adVarChar, adParamOutput, 10, ""));
		}
		Execute(adExecuteNoRecords);
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex));
} finally {
	var Item = Solaren.Map(Cmd.Parameters);
	Solaren.Close();
	if (Solaren.Empty(Item.PurCost)) {
		Message.Write(0, "Інформацію не знайдено");
	} else {
		var Period = Month.GetPeriod(ReportMonth, 1),
		ReportDate = Month.Today.toStr(0);
		Html.SetHead("Службовий лист");
	}
}%>

<STYLE>P { text-align: justify; line-height: 1.5; text-indent: 1cm; margin-bottom: 1}
LI { line-height: 1.5; }
UL { list-style: disc; }
OL { margin-top: 1 }</STYLE>

<BODY CLASS="PrnBody">
<TABLE CLASS="NoBorderTable" WIDTH="100%">
<TR><TD>&nbsp</TD><TD ALIGN="LEFT" WIDTH="55%"><%=Item.TopChiefTitle3%>&nbsp<%=Item.CompanyName%><BR><%=Item.TopChiefName3%><BR><%=Item.ChiefTitle2%><BR><%=Item.ChiefName2%></TD></TR>
</TABLE>
<H3 CLASS="H3PrnTable"><%=Html.Title%></H3>
<P CLASS="acttext">Прошу здiйснити оплату по договору купiвлi-продажу електричної енергiї за "зеленим" тарифом приватним домогосподарством, особовий рахунок №<%=Item.ContractPAN%>,
згiдно акту приймання-передачi електричної енергiї в <%=Period%>:</P>
<OL CLASS="acttext"><LI><%=Item.CustomerName%>
<UL><LI>ІПН: <%=Item.CustomerCode%></LI>
<LI>Код МФО: <%=Item.MfoCode%></LI>
<LI>Рахунок: <%=Item.BankAccount%></LI>
<LI>Банк: <%=Item.BankName%></LI>
<LI>№ картки: <%=Item.CardId%></LI>
<LI>Сума: <%=Item.PurCost.toDelimited(2)%> грн.</LI>
<LI>Призначення: За вироблену активну електроенергiю</LI>
<LI>Термiн оплати: 10 банкiвських днiв</LI></UL>
<LI>Вiйськовий збiр</LI>
<UL><LI>Код МФО: <%=Item.TreasuryMfo%></LI>
<LI>Код ЄДРПОУ: <%=Item.TreasuryCode%></LI>
<LI>Рахунок: <%=Item.TreasuryAccount%></LI>
<LI>Отримувач: <%=Item.TreasuryName%></LI>
<LI>Сума: <%=Item.Vz.toDelimited(2)%> грн.</LI>
<LI>Призначення: *; 101; <%=Item.CompanyCode%>; вiйськовий збiр з <%=Item.CustomerName%> (<%=Item.CustomerCode%>)</LI>
</UL></OL>
<TABLE CLASS="acttext" STYLE="margin-top:60" WIDTH="100%">
<TR><TD VALIGN="BOTTOM" ALIGN="LEFT"><SUB>вик: <%=Item.ContractorName%>, &#9990;<%=Item.Phone%></SUB></TD>
<TD VALIGN="TOP" ALIGN="RIGHT"><SUP><%=ReportDate.formatDate("-")%></SUP>&nbsp;<DIV CLASS="UnderLine"></DIV></TD></TR>
</TABLE></BODY></HTML>
