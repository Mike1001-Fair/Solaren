<%@LANGUAGE="JScript"%>
<!-- #INCLUDE VIRTUAL="Solaren/Set/new.set" -->
<% var Authorized = User.RoleId == 0;
User.CheckAccess(Authorized, "GET");

try {
	Db.SetCmd("SelectChief");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
		}
	}
	var rsChief = Db.Execute("SelectChief", "Довiдник керівників пустий!"),
	rsBank = Db.Execute("SelectBank", "Довідник банкiв пустий!"),
	rsRegion = Db.Execute("SelectRegion", "Довiдник областей пустий!");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Нова компанія")
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewCompany" ACTION="createcompany.asp" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="hidden" NAME="StreetId" ID="StreetId" VALUE="-1">
<INPUT TYPE="hidden" NAME="LocalityId" ID="LocalityId" VALUE="-1">
<H3 CLASS="HeadText"><IMG SRC="Images/office.svg"><%=Html.Title%></H3>

<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<FIELDSET><LEGEND>Загальні</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Назва</TD>
	<TD><INPUT TYPE="TEXT" NAME="CompanyName" SIZE="40" maxLength="40" REQUIRED AUTOFOCUS></TD></TR>
	<TR><TD ALIGN="RIGHT">Код</TD>
	<TD><INPUT TYPE="TEXT" NAME="CompanyCode" PLACEHOLDER="ЄДРПОУ" SIZE="10" maxLength="8" PATTERN="\d{8}" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">Керiвник</TD>
	<TD><% Html.WriteSelect(rsChief, "Chief", 0, -1)%></TD></TR>

	<TR><TD ALIGN="RIGHT">Бухгалтер</TD>
	<TD><INPUT TYPE="TEXT" NAME="Accountant" PLACEHOLDER="ПІБ" SIZE="30" maxLength="30" REQUIRED></TD></TR>
	</TABLE>
	</FIELDSET>

	<FIELDSET><LEGEND>Банк</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Назва</TD>
	<TD><%Html.WriteBank(rsBank, -1)%></TD></TR>

	<TR><TD ALIGN="RIGHT">Рахунок</TD>
	<TD><INPUT TYPE="TEXT" NAME="BankAccount" SIZE="30" MAXLENGTH="30" REQUIRED></TD></TR></TABLE>
	</FIELDSET>

	<FIELDSET><LEGEND>Податки</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">РНОКПП</TD>
	<TD><INPUT TYPE="TEXT" NAME="AccountantTaxCode" SIZE="15" MAXLENGTH="10" PATTERN="\d{10}" PLACEHOLDER="бухгалтера" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">ІПН</TD>
	<TD><INPUT TYPE="TEXT" NAME="TaxCode" SIZE="15"  MAXLENGTH="12" PATTERN="\d{12}" REQUIRED>
	<INPUT TYPE="TEXT" NAME="TaxAdminCode" PLACEHOLDER="код ДПІ" SIZE="5" PATTERN="\d{4}" MAXLENGTH="4" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Статус</TD>
	<TD><INPUT TYPE="TEXT" NAME="TaxStatus" SIZE="40" MAXLENGTH="40" REQUIRED></TD></TR>
	</TABLE></FIELDSET>

	<FIELDSET><LEGEND>Виконавець</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Посада</TD>
	<TD><INPUT TYPE="TEXT" NAME="PerformerTitle" SIZE="30" maxLength="30" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">ПІБ</TD>
	<TD><INPUT TYPE="TEXT" NAME="PerformerName" SIZE="30" maxLength="30" REQUIRED></TD></TR>
	</TABLE></FIELDSET></TD>

	<TD ALIGN="CENTER">
	<FIELDSET><LEGEND>Адреса</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Iндекс</TD>
	<TD><INPUT TYPE="TEXT" NAME="PostIndex" SIZE="10" MAXLENGTH="10" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Будинок</TD>
	<TD><INPUT TYPE="TEXT" NAME="HouseId" SIZE="10" MAXLENGTH="10" REQUIRED></TD></TR>

	<TR><TD ID="StreetType" ALIGN="RIGHT">Вулиця</TD>
	<TD><% Html.WriteInputDataList("Street", "", 30) %></TD></TR>

	<TR><TD ID="LocalityType" ALIGN="RIGHT">Пункт</TD>
	<TD><% Html.WriteInputDataList("Locality", "", 30) %></TD></TR>

	<TR><TD ALIGN="RIGHT">Область</TD>
	<TD><% Html.WriteSelect(rsRegion, "Region", 0, -1)%></TD></TR>
	</TABLE></FIELDSET>

	<FIELDSET><LEGEND>Лiцензiя</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Номер</TD>
	<TD><INPUT TYPE="TEXT" NAME="LicenseCode" SIZE="20" MAXLENGTH="20" REQUIRED>
	<TR><TD ALIGN="RIGHT">Дата</TD>
	<TD><INPUT TYPE="date" NAME="LicenseDate" REQUIRED></TD>
	</TABLE></FIELDSET>

	<FIELDSET><LEGEND>Контакти</LEGEND>
	<TABLE><TR><TD ALIGN="CENTER">📞</TD>
	<TD><INPUT TYPE="TEXT" NAME="Phone" PLACEHOLDER="телефон" SIZE="15" MAXLENGTH="10" PATTERN="\d{5,10}" REQUIRED></TD></TR>
	<TR><TD ALIGN="CENTER">&#128231;</TD>
	<TD><INPUT TYPE="Email" NAME="Email" PLACEHOLDER="email" SIZE="30" MAXLENGTH="30" REQUIRED></TD></TR>
	<TR><TD ALIGN="CENTER">&#127760;</TD>
	<TD><INPUT TYPE="Text" NAME="WebSite" PLACEHOLDER="веб-сайт" SIZE="30" MAXLENGTH="30" REQUIRED></TD></TR>
	</TABLE></FIELDSET>

	<FIELDSET><LEGEND>Інше</LEGEND>
	<LABEL>Логотип <INPUT TYPE="TEXT" NAME="LogoType" SIZE="30" maxLength="30" REQUIRED></LABEL>
	</FIELDSET>
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>Створити</BUTTON>
</FORM></BODY></HTML>
<% Db.Close() %>