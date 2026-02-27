<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/edit.set" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
Query = Webserver.Parse();
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
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("CompanyId", adInteger, adParamInput, 10, Query.CompanyId));
		}
	}
	var rsCompany = Db.Execute("GetCompany", "Компанію не знайдено!");
} catch (ex) {
	Message.Write(3, Message.Error(ex));
} finally {	
	var Company = Webserver.Map(rsCompany.Fields),
	Title = Company.Deleted ? "Перегляд компанії" : "Редагування компанії";
	rsCompany.Close();
	Html.SetPage(Title);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditCompany" ACTION="updatecompany.asp" METHOD="POST" AUTOCOMPLETE="off">
<H3 CLASS="HeadText" ID="H3Id"><IMG SRC="images/office.svg"><%=Html.Title%></H3>
<INPUT TYPE="HIDDEN" NAME="CompanyId" VALUE="<%=Query.CompanyId%>">
<INPUT TYPE="HIDDEN" NAME="LocalityId" ID="LocalityId" VALUE="<%=Company.LocalityId%>">
<INPUT TYPE="hidden" NAME="StreetId" ID="StreetId" VALUE="<%=Company.StreetId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Company.Deleted%>">

<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<FIELDSET><LEGEND>Загальні</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Назва</TD>
	<TD><INPUT TYPE="TEXT" NAME="CompanyName" VALUE="<%=Company.CompanyName%>" SIZE="40" MAXLENGTH="40" REQUIRED AUTOFOCUS></TD></TR>
	<TR><TD ALIGN="RIGHT">Код</TD>
	<TD ALIGN="LEFT"><INPUT TYPE="TEXT" NAME="CompanyCode" PLACEHOLDER="ЄДРПОУ" VALUE="<%=Company.CompanyCode%>" SIZE="10" MAXLENGTH="8" PATTERN="\d{8}" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Керiвник</TD>
	<TD><% Html.WriteSelect(rsChief, "Chief", 0, Company.ChiefId)%></TD></TR>

	<TR><TD ALIGN="RIGHT">Бухгалтер</TD>
	<TD ALIGN="LEFT"><INPUT TYPE="TEXT" NAME="Accountant" PLACEHOLDER="ПІБ" VALUE="<%=Company.Accountant%>" SIZE="30" maxLength="30" REQUIRED></TD></TR>
	</TABLE></FIELDSET>

        <FIELDSET><LEGEND>Банк</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Назва</TD>
	<TD><%Html.WriteBank(rsBank, Company.MfoCode)%></TD></TR>

	<TR><TD ALIGN="RIGHT">Рахунок</TD>
	<TD><INPUT TYPE="TEXT" NAME="BankAccount" VALUE="<%=Company.BankAccount%>" SIZE="30" MINLENGTH="29" MAXLENGTH="29" REQUIRED></TD></TR>
	</TABLE></FIELDSET>

	<FIELDSET><LEGEND>Податки</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">РНОКПП</TD>
	<TD><INPUT TYPE="TEXT" NAME="AccountantTaxCode" VALUE="<%=Company.AccountantTaxCode%>" SIZE="15" MAXLENGTH="10" PATTERN="\d{10}" PLACEHOLDER="бухгалтера" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">ІПН</TD>
	<TD><INPUT TYPE="TEXT" NAME="TaxCode" SIZE="15" VALUE="<%=Company.TaxCode%>" PATTERN="\d{12}" MAXLENGTH="12" REQUIRED>
	<INPUT TYPE="TEXT" NAME="TaxAdminCode" PLACEHOLDER="код ДПІ" SIZE="5" VALUE="<%=Company.TaxAdminCode%>" PATTERN="\d{4}" MAXLENGTH="4" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Статус</TD>
	<TD><INPUT TYPE="TEXT" NAME="TaxStatus" VALUE="<%=Company.TaxStatus%>" SIZE="40" MAXLENGTH="40" REQUIRED></TD></TR>
	</TABLE></FIELDSET>

	<FIELDSET><LEGEND>Виконавець</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Посада</TD>
	<TD><INPUT TYPE="TEXT" NAME="PerformerTitle" VALUE="<%=Company.PerformerTitle%>" SIZE="30" maxLength="30" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">ПІБ</TD>
	<TD><INPUT TYPE="TEXT" NAME="PerformerName" VALUE="<%=Company.PerformerName%>" SIZE="30" maxLength="30" REQUIRED></TD></TR>
	</TABLE></FIELDSET></TD>

	<TD ALIGN="CENTER"><FIELDSET><LEGEND>Адреса</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Iндекс</TD>
	<TD><INPUT TYPE="TEXT" NAME="PostIndex" VALUE="<%=Company.PostIndex%>" PATTERN="\d{5}" SIZE="10" MAXLENGTH="5" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Будинок</TD>
	<TD><INPUT TYPE="TEXT" NAME="HouseId" VALUE="<%=Company.HouseId%>" SIZE="10" MAXLENGTH="10" REQUIRED></TD></TR>

	<TR><TD ID="StreetType" ALIGN="RIGHT">Вулиця</TD>
	<TD><% Html.WriteInputDataList("Street", Company.StreetName, 30) %></TD></TR>

	<TR><TD ID="LocalityType" ALIGN="RIGHT">Пункт</TD>
	<TD><% Html.WriteInputDataList("Locality", Company.LocalityName, 30) %></TD></TR>

	<TR><TD ALIGN="RIGHT">Область</TD>
	<TD><%Html.WriteSelect(rsRegion, "Region", 0, Company.RegionId)%></TD></TR>
	</TABLE></FIELDSET>

	<FIELDSET><LEGEND>Лiцензiя</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Номер</TD>
	<TD><INPUT TYPE="TEXT" NAME="LicenseCode" VALUE="<%=Company.LicenseCode%>" SIZE="20" MAXLENGTH="20" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">Дата</TD>
	<TD><INPUT TYPE="date" NAME="LicenseDate" VALUE="<%=Company.LicenseDate%>" REQUIRED></TD></TR>
	</TABLE></FIELDSET>

	<FIELDSET><LEGEND>Контакти</LEGEND>
	<TABLE><TR><TD ALIGN="CENTER">📞</TD>
	<TD><INPUT TYPE="TEXT" NAME="Phone" PLACEHOLDER="телефон" VALUE="<%=Company.Phone%>" SIZE="15" MAXLENGTH="10" PATTERN="\d{5,10}" REQUIRED></TD></TR>
	<TR><TD>&#128231;</TD>
	<TD><INPUT TYPE="Email" NAME="Email" PLACEHOLDER="email" VALUE="<%=Company.Email%>" SIZE="30" MAXLENGTH="30" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">&#127760;</TD>
	<TD><INPUT TYPE="Text" NAME="WebSite" PLACEHOLDER="веб-сайт" VALUE="<%=Company.WebSite%>" SIZE="30" MAXLENGTH="30" REQUIRED></TD></TR>
	</TABLE></FIELDSET>

	<FIELDSET><LEGEND>Інше</LEGEND>
	<LABEL>Логотип <INPUT TYPE="TEXT" NAME="LogoType" VALUE="<%=Company.LogoType%>" SIZE="30" maxLength="30" REQUIRED></LABEL>
	</FIELDSET>
	</TD></TR>	
</TABLE>
<% Html.WriteEditButton(1, Company.Deleted);
Db.Close(); %>
</FORM></BODY></HTML>