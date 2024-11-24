<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var RoleId = Session("RoleId"),
Authorized = RoleId < 2,
CompanyId = Request.QueryString("CompanyId");

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

try {
	Solaren.SetCmd("SelectChief");
	Cmd.Parameters.Append(Cmd.CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
	var rsChief = Solaren.Execute("SelectChief", "Довiдник керівників пустий!"),
	rsBank = Solaren.Execute("SelectBank", "Довідник банкiв пустий!"),
	rsRegion = Solaren.Execute("SelectRegion", "Довiдник областей пустий!");
	Cmd.Parameters.Append(Cmd.CreateParameter("CompanyId", adInteger, adParamInput, 10, CompanyId));
	var rsCompany = Solaren.Execute("GetCompany", "Компанію не знайдено!");
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex));
}

with (rsCompany) {
	var ChiefId  = Fields("ChiefId").value,
	CompanyName  = Fields("CompanyName").value,
	CompanyCode  = Fields("CompanyCode").value,
	Accountant   = Fields("Accountant").value,
	LogoType     = Fields("LogoType").value,

	PostIndex    = Fields("PostIndex").value,
	HouseId      = Fields("HouseId").value,
	StreetId     = Fields("StreetId").value,
	StreetName   = Fields("StreetName").value,
	LocalityId   = Fields("LocalityId").value,
	LocalityName = Fields("LocalityName").value,
	RegionId     = Fields("RegionId").value,

	MfoCode      = Fields("MfoCode").value,
	BankAccount  = Fields("BankAccount").value,

	LicenseCode  = Fields("LicenseCode").value,
	LicenseDate  = Fields("LicenseDate").value,

	AccountantTaxCode = Fields("AccountantTaxCode").value,
	TaxCode           = Fields("TaxCode").value,
	TaxAdminCode      = Fields("TaxAdminCode").value,
	TaxStatus	  = Fields("TaxStatus").value,

	Phone   = Fields("Phone").value,
	Email   = Fields("Email").value,
	WebSite = Fields("WebSite").value,

	PerformerTitle = Fields("PerformerTitle").value,
	PerformerName  = Fields("PerformerName").value,
	Deleted        = Fields("Deleted").value,
	HeadTitle      = Deleted ? "Перегляд компанії" : "Редагування компанії";
	Close();
}

with (Html) {
	SetHead(HeadTitle);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditCompany" ACTION="updatecompany.asp" METHOD="POST" AUTOCOMPLETE="off">
<H3 CLASS="HeadText" ID="H3Id"><IMG SRC="images/office.svg"><%=HeadTitle%></H3>
<INPUT TYPE="HIDDEN" NAME="CompanyId" VALUE="<%=CompanyId%>">
<INPUT TYPE="HIDDEN" NAME="LocalityId" ID="LocalityId" VALUE="<%=LocalityId%>">
<INPUT TYPE="hidden" NAME="StreetId" ID="StreetId" VALUE="<%=StreetId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">

<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<FIELDSET><LEGEND>Загальні</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Назва</TD>
	<TD><INPUT TYPE="TEXT" NAME="CompanyName" VALUE="<%=CompanyName%>" SIZE="40" MAXLENGTH="40" REQUIRED AUTOFOCUS></TD></TR>
	<TR><TD ALIGN="RIGHT">Код</TD>
	<TD ALIGN="LEFT"><INPUT TYPE="TEXT" NAME="CompanyCode" PLACEHOLDER="ЄДРПОУ" VALUE="<%=CompanyCode%>" SIZE="10" MAXLENGTH="8" PATTERN="\d{8}" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Керiвник</TD>
	<TD><% Html.WriteSelect(rsChief, "Chief", 0, ChiefId)%></TD></TR>

	<TR><TD ALIGN="RIGHT">Бухгалтер</TD>
	<TD ALIGN="LEFT"><INPUT TYPE="TEXT" NAME="Accountant" PLACEHOLDER="ПІБ" VALUE="<%=Accountant%>" SIZE="30" maxLength="30" REQUIRED></TD></TR>
	</TABLE></FIELDSET>

        <FIELDSET><LEGEND>Банк</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Назва</TD>
	<TD><%Html.WriteBank(rsBank, MfoCode)%></TD></TR>

	<TR><TD ALIGN="RIGHT">Рахунок</TD>
	<TD><INPUT TYPE="TEXT" NAME="BankAccount" VALUE="<%=BankAccount%>" SIZE="30" MINLENGTH="29" MAXLENGTH="29" REQUIRED></TD></TR>
	</TABLE></FIELDSET>

	<FIELDSET><LEGEND>Податки</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">РНОКПП</TD>
	<TD><INPUT TYPE="TEXT" NAME="AccountantTaxCode" VALUE="<%=AccountantTaxCode%>" SIZE="15" MAXLENGTH="10" PATTERN="\d{10}" PLACEHOLDER="бухгалтера" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">ІПН</TD>
	<TD><INPUT TYPE="TEXT" NAME="TaxCode" SIZE="15" VALUE="<%=TaxCode%>" PATTERN="\d{12}" MAXLENGTH="12" REQUIRED>
	<INPUT TYPE="TEXT" NAME="TaxAdminCode" PLACEHOLDER="код ДПІ" SIZE="5" VALUE="<%=TaxAdminCode%>" PATTERN="\d{4}" MAXLENGTH="4" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Статус</TD>
	<TD><INPUT TYPE="TEXT" NAME="TaxStatus" VALUE="<%=TaxStatus%>" SIZE="40" MAXLENGTH="40" REQUIRED></TD></TR>
	</TABLE></FIELDSET>

        <FIELDSET><LEGEND>Виконавець</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Посада</TD>
	<TD><INPUT TYPE="TEXT" NAME="PerformerTitle" VALUE="<%=PerformerTitle%>" SIZE="30" maxLength="30" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">ПІБ</TD>
	<TD><INPUT TYPE="TEXT" NAME="PerformerName" VALUE="<%=PerformerName%>" SIZE="30" maxLength="30" REQUIRED></TD></TR>
	</TABLE></FIELDSET></TD>

	<TD ALIGN="CENTER"><FIELDSET><LEGEND>Адреса</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Iндекс</TD>
	<TD><INPUT TYPE="TEXT" NAME="PostIndex" VALUE="<%=PostIndex%>" PATTERN="\d{5}" SIZE="10" MAXLENGTH="5" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Будинок</TD>
	<TD><INPUT TYPE="TEXT" NAME="HouseId" VALUE="<%=HouseId%>" SIZE="10" MAXLENGTH="10" REQUIRED></TD></TR>

	<TR><TD ID="StreetType" ALIGN="RIGHT">Вулиця</TD>
	<TD><INPUT TYPE="search" NAME="StreetName" ID="StreetName" VALUE="<%=StreetName%>" PLACEHOLDER="Пошук по літерам" SIZE="30" LIST="StreetList" REQUIRED>
	<DATALIST ID="StreetList"></DATALIST></TD></TR>

	<TR><TD ALIGN="RIGHT" ID="LocalityType">Місто</TD>
	<TD><INPUT TYPE="search" NAME="LocalityName" ID="LocalityName" VALUE="<%=LocalityName%>" PLACEHOLDER="Пошук по літерам" SIZE="30" LIST="LocalityList" REQUIRED>
	<DATALIST ID="LocalityList"></DATALIST></TD></TR>

	<TR><TD ALIGN="RIGHT">Область</TD>
	<TD><%Html.WriteSelect(rsRegion, "Region", 0, RegionId)%></TD></TR>
	</TABLE></FIELDSET>

	<FIELDSET><LEGEND>Лiцензiя</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Номер</TD>
	<TD><INPUT TYPE="TEXT" NAME="LicenseCode" VALUE="<%=LicenseCode%>" SIZE="20" MAXLENGTH="20" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">Дата</TD>
	<TD><INPUT TYPE="date" NAME="LicenseDate" VALUE="<%=LicenseDate%>" REQUIRED></TD></TR>
	</TABLE></FIELDSET>

	<FIELDSET><LEGEND>Контакти</LEGEND>
	<TABLE><TR><TD ALIGN="CENTER">📞</TD>
	<TD><INPUT TYPE="TEXT" NAME="Phone" PLACEHOLDER="телефон" VALUE="<%=Phone%>" SIZE="15" MAXLENGTH="10" PATTERN="\d{5,10}" REQUIRED></TD></TR>
	<TR><TD>&#128231;</TD>
	<TD><INPUT TYPE="Email" NAME="Email" PLACEHOLDER="email" VALUE="<%=Email%>" SIZE="30" MAXLENGTH="30" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">&#127760;</TD>
	<TD><INPUT TYPE="Text" NAME="WebSite" PLACEHOLDER="веб-сайт" VALUE="<%=WebSite%>" SIZE="30" MAXLENGTH="30" REQUIRED></TD></TR>
	</TABLE></FIELDSET>

	<FIELDSET><LEGEND>Інше</LEGEND>
	<LABEL>Логотип <INPUT TYPE="TEXT" NAME="LogoType" VALUE="<%=LogoType%>" SIZE="30" maxLength="30" REQUIRED></LABEL>
	</FIELDSET>
	</TD></TR>	
</TABLE>
<% Html.WriteEditButton(1);
Connect.Close(); %>
</FORM></BODY></HTML>