<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<!-- #INCLUDE FILE="Include/tarif.inc" -->
<% var Authorized = User.RoleId == 1;
User.ValidateAccess(Authorized, "GET");

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
} catch (ex) {
	Message.Write(3, Message.Error(ex));
}

Html.SetPage("Новий договір")%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewContract" ACTION="createcontract.asp" METHOD="post" AUTOCOMPLETE="off" TARGET="_blank">
<INPUT TYPE="HIDDEN" NAME="CustomerId" ID="CustomerId" VALUE="-1">
<INPUT TYPE="HIDDEN" NAME="CheckCard" VALUE="<%=Session("CheckCard")%>">
<INPUT TYPE="hidden" NAME="LocalityId" ID="LocalityId" VALUE="-1">
<INPUT TYPE="HIDDEN" NAME="StreetId" ID="StreetId" VALUE="-1">

<H3 CLASS="HeadText"><BIG>&#128214;</BIG><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET><LEGEND>Загальні</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Споживач</TD>
	<TD><% Html.WriteInputDataList("Customer", "", 35, 1) %></TD></TR>

	<TR><TD ALIGN="RIGHT">Рахунок</TD>
	<TD><INPUT TYPE="TEXT" NAME="PAN" SIZE="9" MAXLENGTH="9" REQUIRED PATTERN="\d{9}"></TD></TR>
	<TR><TD ALIGN="RIGHT">EIC</TD>
	<TD><INPUT TYPE="TEXT" NAME="EICode" VALUE="62Z" SIZE="16" MAXLENGTH="16" PATTERN="[A-Z0-9]{16}" REQUIRED></TD></TR>
	</TABLE></FIELDSET>

	<FIELDSET>
	<LEGEND ALIGN="CENTER"><LABEL><INPUT TYPE="CheckBox" NAME="Pay" CHECKED>Сплачувати</LABEL></LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Банк</TD>
	<TD><%Html.WriteBank(rsBank, -1)%></TD></TR>

	<TR><TD ALIGN="RIGHT">Рахунок</TD>
	<TD><INPUT TYPE="TEXT" NAME="BankAccount" SIZE="16" MAXLENGTH="16" PATTERN="\d{1,16}" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Картка</TD>
	<TD><INPUT TYPE="TEXT" NAME="CardId" SIZE="16" MAXLENGTH="16" PATTERN="\d{1,16}">
	<INPUT TYPE="CheckBox" NAME="Account" TITLE="Рахунок"></TD></TR>
	</TABLE></FIELDSET>

	<FIELDSET><LEGEND ALIGN="CENTER">Договір</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">ЦОС</TD>
	<TD><% Html.WriteSelect(rsBranch, "Branch", 0, -1)%></TD></TR>

	<TR><TD ALIGN="RIGHT">Дата</TD>
	<TD><INPUT TYPE="date" NAME="ContractDate" VALUE="<%=Month.Date[1]%>" MIN="<%=Month.Date[0]%>" MAX="<%=Month.Date[2]%>" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">IBAN</TD>
	<TD><INPUT TYPE="TEXT" NAME="Iban" SIZE="29" MAXLENGTH="29" REQUIRED>
	<INPUT TYPE="CheckBox" NAME="IbanBox" ID="IbanBox" TITLE="Сгенерувати"></TD></TR>
	</TABLE></FIELDSET></TD>

	<TD><FIELDSET><LEGEND>Адреса</LEGEND>
	<TABLE><TR><TD ID="LocalityType" ALIGN="RIGHT">Пункт</TD>
	<TD><% Html.WriteInputDataList("Locality", "", 30) %></TD></TR>

	<TR><TD ID="StreetType" ALIGN="RIGHT">Вулиця</TD>
	<TD><% Html.WriteInputDataList("Street", "", 30) %></TD></TR>

	<TR><TD ALIGN="RIGHT">Будинок</TD>
	<TD><INPUT TYPE="TEXT" NAME="HouseId" SIZE="20" MAXLENGTH="15" REQUIRED></TD></TR>
	</TABLE></FIELDSET>

	<FIELDSET><LEGEND ALIGN="CENTER">Електроустановка</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Потужнiсть</TD>
	<TD><INPUT TYPE="Number" NAME="ContractPower" STEP="0.01" MIN="0" MAX="50" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Дата вводу</TD>
	<TD><INPUT TYPE="date" NAME="ExpDate" VALUE="<%=Month.Date[1]%>" MIN="<%=Month.Date[0]%>" MAX="<%=Month.Date[2]%>" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Тарифна група</TD>
	<TD><%Tarif.Write("TarifGroupId", -1)%></TD></TR>
	</TABLE></FIELDSET>

	<FIELDSET><LEGEND ALIGN="CENTER">Інше</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">РЕМ</TD>
	<TD><%Html.WriteSelect(rsAen, "Aen", 0, -1)%></TD></TR>

	<TR><TD ALIGN="RIGHT">Оператор</TD>
	<TD><%Html.WriteSelect(rsOperator, "Operator", 0, -1)%></TD></TR>

	<TR><TD ALIGN="RIGHT">Виконавець</TD>
	<TD><%Html.WriteSelect(rsPerformer, "Performer", 0, -1);
	Solaren.Close() %></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>Створити</BUTTON>
</FORM></BODY></HTML>



