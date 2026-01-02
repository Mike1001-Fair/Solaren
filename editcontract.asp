<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/edit.set" -->
<% var Authorized = User.RoleId == 1,
Query = Solaren.Parse();
User.CheckAccess(Authorized, "GET");

try {
	Solaren.SetCmd("SelectBank");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
		}
	}
	var rsBank = Solaren.Execute("SelectBank", "Довідник банкiв пустий!"),
	rsBranch = Solaren.Execute("SelectBranch", "Довiдник ЦОС пустий!"),
	rsAen =	Solaren.Execute("SelectAen", "Довiдник РЕМ пустий!"),
	rsOperator = Solaren.Execute("SelectOperator", "Довiдник операторів пустий!"),
	rsPerformer = Solaren.Execute("SelectPerformer", "Довiдник виконавців пустий!");

	with (Cmd) {
		with (Parameters) {
    			Append(CreateParameter("ContractId", adInteger, adParamInput, 10, Query.ContractId));
		}
	}
	var rsContract = Solaren.Execute("GetContract", "Договір не знайдено!");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	var Contract = Solaren.Map(rsContract.Fields);
	rsContract.Close();
	Html.SetPage(Contract.Deleted ? "Перегляд договору" : "Редагування договору");
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditContract" ACTION="updatecontract.asp" METHOD="POST" AUTOCOMPLETE="off">
<INPUT TYPE="HIDDEN" NAME="CustomerId" ID="CustomerId" VALUE="<%=Contract.CustomerId%>">
<INPUT TYPE="HIDDEN" NAME="ContractId" VALUE="<%=Query.ContractId%>">
<INPUT TYPE="HIDDEN" NAME="LocalityId" ID="LocalityId" VALUE="<%=Contract.LocalityId%>">
<INPUT TYPE="HIDDEN" NAME="StreetId" ID="StreetId" VALUE="<%=Contract.StreetId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Contract.Deleted%>">
<INPUT TYPE="HIDDEN" NAME="CheckCard" VALUE="<%=Session("CheckCard")%>">

<H3 CLASS="HeadText"><BIG>&#128214;</BIG><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<FIELDSET><LEGEND>Загальні</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Споживач</TD>
	<TD><% Html.WriteInputDataList("Customer", Contract.CustomerName, 35) %></TD></TR>

	<TR><TD ALIGN="RIGHT">Рахунок</TD>
	<TD><INPUT TYPE="TEXT" NAME="PAN" VALUE="<%=Contract.PAN%>" SIZE="9" MAXLENGTH="9" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">EIC</TD>
	<TD><INPUT TYPE="TEXT" NAME="EICode" VALUE="<%=Contract.EICode%>" SIZE="16" MAXLENGTH="16" PATTERN="[A-Z0-9]{16}" REQUIRED></TD></TR></TABLE></FIELDSET>

	<FIELDSET><LEGEND><LABEL><INPUT TYPE="CheckBox" NAME="Pay" <%=Contract.Pay ? "CHECKED" : ""%>>Сплачувати</LABEL></LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Банк</TD>
	<TD><%Html.WriteBank(rsBank, Contract.MfoCode)%></TD></TR>

	<TR><TD ALIGN="RIGHT">Рахунок</TD>
	<TD><INPUT TYPE="TEXT" NAME="BankAccount" VALUE="<%=Contract.BankAccount%>" SIZE="16" maxLength="16" PATTERN="^\d{1,16}$" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Картка</TD>
	<TD><INPUT TYPE="TEXT" NAME="CardId" VALUE="<%=Contract.CardId%>" SIZE="16" maxLength="16" PATTERN="^\d{1,16}$">
	<INPUT TYPE="CheckBox" NAME="Account" TITLE="Рахунок"></TD></TR>
	</TABLE></FIELDSET>

	<FIELDSET><LEGEND>Договір</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">ЦОС</TD>
	<TD><% Html.WriteSelect(rsBranch, "Branch", 0, Contract.BranchId)%></TD></TR>

	<TR><TD ALIGN="RIGHT">Дата</TD>
	<TD><INPUT TYPE="date" NAME="ContractDate" VALUE="<%=Contract.ContractDate%>" MIN="<%=Month.Date[0]%>" MAX="<%=Month.Date[2]%>" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">IBAN</TD>
	<TD><INPUT TYPE="TEXT" NAME="Iban" SIZE="29" VALUE="<%=Contract.Iban%>" MAXLENGTH="29" PATTERN="[A-Z0-9]{29}" REQUIRED>
	<INPUT TYPE="CheckBox" NAME="IbanBox" ID="IbanBox" TITLE="Сгенерувати"></TD></TR></TABLE></FIELDSET></TD>

	<TD><FIELDSET><LEGEND>Адреса</LEGEND>
	<TABLE><TR><TD ID="LocalityType" ALIGN="RIGHT">Пункт</TD>
	<TD><% Html.WriteInputDataList("Locality", Contract.LocalityName, 30) %></TD></TR>

	<TR><TD ID="StreetType" ALIGN="RIGHT">Вулиця</TD>
	<TD><% Html.WriteInputDataList("Street", Contract.StreetName, 30) %></TD></TR>
	
	<TR><TD ALIGN="RIGHT">Будинок</TD>
	<TD><INPUT TYPE="TEXT" NAME="HouseId" VALUE="<%=Contract.HouseId%>" SIZE="20" MAXLENGTH="15" REQUIRED></TD></TR>
	</TABLE></FIELDSET>

	<FIELDSET><LEGEND ALIGN="CENTER">Електроустановка</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Потужнiсть</TD>
	<TD><INPUT TYPE="Number" NAME="ContractPower" VALUE="<%=Contract.ContractPower%>" STEP="0.01" MIN="0" MAX="50" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">Дата вводу</TD>
	<TD><INPUT TYPE="date" NAME="ExpDate" VALUE="<%=Contract.ExpDate%>" SIZE="10" MIN="<%=Month.Date[0]%>" MAX="<%=Month.Date[2]%>" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Група</TD>
	<TD><%Tarif.Write("TarifGroupId", Contract.TarifGroupId)%></TD></TR>
	</TABLE></FIELDSET>

	<FIELDSET><LEGEND>Інше</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">РЕМ</TD>
	<TD><%Html.WriteSelect(rsAen, "Aen", 0, Contract.AenId)%></TD></TR>
	
	<TR><TD ALIGN="RIGHT">Оператор</TD>
	<TD><%Html.WriteSelect(rsOperator, "Operator", 0, Contract.OperatorId)%></TD></TR>

	<TR><TD ALIGN="RIGHT">Виконавець</TD>
	<TD><%Html.WriteSelect(rsPerformer, "Performer", 0, Contract.PerformerId)%></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<% Html.WriteEditButton(1, Contract.Deleted);
Solaren.Close();%>
</FORM></BODY></HTML>
