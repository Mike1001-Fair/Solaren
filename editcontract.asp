<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var RoleId = Session("RoleId"),
Authorized = RoleId == 1,
ContractId = Request.QueryString("ContractId");

if (!Authorized) {
	Solaren.SysMsg(2, "Помилка авторизації");
}

try {
	Solaren.SetCmd("SelectBank");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
		}
	}
	var rsBank = Solaren.Execute("SelectBank", "Довідник банкiв пустий!"),
	rsBranch = Solaren.Execute("SelectBranch", "Довiдник ЦОС пустий!"),
	rsAen =	Solaren.Execute("SelectAen", "Довiдник РЕМ пустий!"),
	rsOperator = Solaren.Execute("SelectOperator", "Довiдник операторів пустий!"),
	rsPerformer = Solaren.Execute("SelectPerformer", "Довiдник виконавців пустий!");

	with (Cmd) {
		with (Parameters) {
    			Append(CreateParameter("ContractId", adInteger, adParamInput, 10, ContractId));
		}
	}
	var rsContract = Solaren.Execute("GetContract", "Договір не знайдено!");
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
} finally {
	with (rsContract) {
		var CustomerId = Fields("CustomerId").value,
		CustomerName   = Fields("CustomerName").value,
		PAN            = Fields("PAN").value,
		EICode         = Fields("EICode").value,
		Pay            = Fields("Pay").value,
		LocalityId     = Fields("LocalityId").value,
		LocalityName   = Fields("LocalityName").value,
		StreetId       = Fields("StreetId").value,
		StreetName     = Fields("StreetName").value,
		HouseId        = Fields("HouseId").value,
		ContractPower  = Fields("ContractPower").value,
		ExpDate        = Fields("ExpDate").value,
		ContractDate   = Fields("ContractDate").value,
		MfoCode        = Fields("MfoCode").value,
		BankAccount    = Fields("BankAccount").value,
		CardId         = Fields("CardId").value,
		BranchId       = Fields("BranchId").value,
		AenId          = Fields("AenId").value,
		OperatorId     = Fields("OperatorId").value,
		TarifGroupId   = Fields("TarifGroupId").value,
		Iban           = Fields("Iban").value,
		PerformerId    = Fields("PerformerId").value,
		Deleted        = Fields("Deleted").value,
		Title          = Deleted ? "Перегляд договору" : "Редагування договору";
		Close();
	}
	Html.SetPage(Title, RoleId)
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditContract" ACTION="updatecontract.asp" METHOD="POST" AUTOCOMPLETE="off">
<INPUT TYPE="HIDDEN" NAME="CustomerId" ID="CustomerId" VALUE="<%=CustomerId%>">
<INPUT TYPE="HIDDEN" NAME="ContractId" VALUE="<%=ContractId%>">
<INPUT TYPE="HIDDEN" NAME="LocalityId" ID="LocalityId" VALUE="<%=LocalityId%>">
<INPUT TYPE="HIDDEN" NAME="StreetId" ID="StreetId" VALUE="<%=StreetId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">
<INPUT TYPE="HIDDEN" NAME="CheckCard" VALUE="<%=Session("CheckCard")%>">

<H3 CLASS="HeadText"><BIG>&#128214;</BIG><%=Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<FIELDSET><LEGEND>Загальні</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Споживач</TD>
	<TD><INPUT TYPE="search" NAME="CustomerName" ID="CustomerName" VALUE="<%=CustomerName%>" PLACEHOLDER="Пошук по літерам" SIZE="35" LIST="CustomerList" REQUIRED>
	<DATALIST ID="CustomerList"></DATALIST></TD></TR>

	<TR><TD ALIGN="RIGHT">Рахунок</TD>
	<TD><INPUT TYPE="TEXT" NAME="PAN" VALUE="<%=PAN%>" SIZE="9" MAXLENGTH="9" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">EIC</TD>
	<TD><INPUT TYPE="TEXT" NAME="EICode" VALUE="<%=EICode%>" SIZE="16" MAXLENGTH="16" PATTERN="[A-Z0-9]{16}" REQUIRED></TD></TR></TABLE></FIELDSET>

	<FIELDSET><LEGEND><LABEL><INPUT TYPE="CheckBox" NAME="Pay" <%=Pay ? "CHECKED" : ""%>>Сплачувати</LABEL></LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Банк</TD>
	<TD><%Html.WriteBank(rsBank, MfoCode)%></TD></TR>

	<TR><TD ALIGN="RIGHT">Рахунок</TD>
	<TD><INPUT TYPE="TEXT" NAME="BankAccount" VALUE="<%=BankAccount%>" SIZE="16" maxLength="16" PATTERN="^\d{1,16}$" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Картка</TD>
	<TD><INPUT TYPE="TEXT" NAME="CardId" VALUE="<%=CardId%>" SIZE="16" maxLength="16" PATTERN="^\d{1,16}$">
	<INPUT TYPE="CheckBox" NAME="Account" TITLE="Рахунок"></TD></TR>
	</TABLE></FIELDSET>

	<FIELDSET><LEGEND>Договір</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">ЦОС</TD>
	<TD><%Html.WriteBranch(rsBranch, BranchId, 0)%></TD></TR>

	<TR><TD ALIGN="RIGHT">Дата</TD>
	<TD><INPUT TYPE="date" NAME="ContractDate" VALUE="<%=ContractDate%>" MIN="<%=Html.MinDate%>" MAX="<%=Session("EndDate")%>" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">IBAN</TD>
	<TD><INPUT TYPE="TEXT" NAME="Iban" SIZE="29" VALUE="<%=Iban%>" MAXLENGTH="29" PATTERN="[A-Z0-9]{29}" REQUIRED>
	<INPUT TYPE="CheckBox" NAME="IbanBox" ID="IbanBox" TITLE="Сгенерувати"></TD></TR></TABLE></FIELDSET></TD>


	<TD><FIELDSET><LEGEND>Адреса</LEGEND>
	<TABLE><TR><TD ID="LocalityType" ALIGN="RIGHT">Пункт</TD>
	<TD><INPUT TYPE="search" NAME="LocalityName" ID="LocalityName" VALUE="<%=LocalityName%>" PLACEHOLDER="Пошук по літерам" SIZE="30" LIST="LocalityList" REQUIRED>
	<DATALIST ID="LocalityList"></DATALIST></TD></TR>

	<TR><TD ID="StreetType" ALIGN="RIGHT">Вулиця</TD>
	<TD><INPUT TYPE="search" NAME="StreetName" ID="StreetName" VALUE="<%=StreetName%>" PLACEHOLDER="Пошук по літерам" SIZE="30" LIST="StreetList" REQUIRED>
	<DATALIST ID="StreetList"></DATALIST></TD></TR>
	
	<TR><TD ALIGN="RIGHT">Будинок</TD>
	<TD><INPUT TYPE="TEXT" NAME="HouseId" VALUE="<%=HouseId%>" SIZE="20" MAXLENGTH="15" REQUIRED></TD></TR>
	</TABLE></FIELDSET>


	<FIELDSET><LEGEND ALIGN="CENTER">Електроустановка</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Потужнiсть</TD>
	<TD><INPUT TYPE="Number" NAME="ContractPower" VALUE="<%=ContractPower%>" STEP="0.01" MIN="0" MAX="50" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">Дата вводу</TD>
	<TD><INPUT TYPE="date" NAME="ExpDate" VALUE="<%=ExpDate%>" SIZE="10" MIN="<%=Html.MinDate%>" MAX="<%=Session("EndDate")%>" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Тарифна група</TD>
	<TD><%Html.WriteTarif("TarifGroupId", TarifGroupId)%></TD></TR>
	</TABLE></FIELDSET>

	<FIELDSET><LEGEND>Інше</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">РЕМ</TD>
	<TD><%Html.WriteAen(rsAen, AenId)%></TD></TR>
	
	<TR><TD ALIGN="RIGHT">Оператор</TD>
	<TD><%Html.WriteOperator(rsOperator, OperatorId)%></TD></TR>

	<TR><TD ALIGN="RIGHT">Виконавець</TD>
	<TD><%Html.WritePerformer(rsPerformer, PerformerId)%></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<% Html.WriteEditButton(1);
Connect.Close();%>
</FORM></BODY></HTML>