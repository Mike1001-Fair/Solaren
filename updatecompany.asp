<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<% var Authorized = Session("RoleId") >= 0 || Session("RoleId") < 2;
if (!Authorized) Message.Write(2, "Помилка авторизації");

with (Request) {
	var CompanyId     = Form("CompanyId"),
	CompanyName       = Form("CompanyName"),
	CompanyCode       = Form("CompanyCode"),
	ChiefId           = Form("ChiefId"),
	Accountant        = Form("Accountant"),
	LogoType          = Form("LogoType"),
	PostIndex         = Form("PostIndex"),
	HouseId           = Form("HouseId"),
	StreetId          = Form("StreetId"),
	LocalityId        = Form("LocalityId"),
	RegionId          = Form("RegionId"),
	MfoCode           = Form("MfoCode"),
	BankAccount       = Form("BankAccount"),
	LicenseCode       = Form("LicenseCode"),
	LicenseDate       = Form("LicenseDate"),
	AccountantTaxCode = Form("AccountantTaxCode"),
	TaxCode           = Form("TaxCode"),
	TaxAdminCode      = Form("TaxAdminCode"),
	TaxStatus         = Form("TaxStatus"),
	Phone             = Form("Phone"),
	Email             = Form("Email"),
	WebSite           = Form("WebSite"),
	PerformerTitle    = Form("PerformerTitle"),
	PerformerName     = Form("PerformerName");
}

try {
	Solaren.SetCmd("UpdateCompany");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("CompanyId", adInteger, adParamInput, 10, CompanyId));
			Append(CreateParameter("CompanyName", adVarChar, adParamInput, 50, CompanyName));
			Append(CreateParameter("CompanyCode", adVarChar, adParamInput, 10, CompanyCode));
			Append(CreateParameter("ChiefId", adInteger, adParamInput, 10, ChiefId));
			Append(CreateParameter("Accountant", adVarChar, adParamInput, 30, Accountant));
			Append(CreateParameter("LogoType", adVarChar, adParamInput, 50, LogoType));

			Append(CreateParameter("PostIndex", adVarChar, adParamInput, 10, PostIndex));
			Append(CreateParameter("HouseId", adVarChar, adParamInput, 10, HouseId));
			Append(CreateParameter("StreetId", adVarChar, adParamInput, 10, StreetId));
			Append(CreateParameter("LocalityId", adInteger, adParamInput, 10, LocalityId));
			Append(CreateParameter("RegionId", adInteger, adParamInput, 10, RegionId));

			Append(CreateParameter("MfoCode", adVarChar, adParamInput, 10, MfoCode));
			Append(CreateParameter("BankAccount", adVarChar, adParamInput, 30, BankAccount));

			Append(CreateParameter("LicenseCode", adVarChar, adParamInput, 20, LicenseCode));
			Append(CreateParameter("LicenseDate", adVarChar, adParamInput, 10, LicenseDate));

			Append(CreateParameter("AccountantTaxCode", adVarChar, adParamInput, 10, AccountantTaxCode));
			Append(CreateParameter("TaxCode", adVarChar, adParamInput, 15, TaxCode));
			Append(CreateParameter("TaxAdminCode", adVarChar, adParamInput, 5, TaxAdminCode));
			Append(CreateParameter("TaxStatus", adVarChar, adParamInput, 40, TaxStatus));

			Append(CreateParameter("Phone", adVarChar, adParamInput, 10, Phone));
			Append(CreateParameter("Email", adVarChar, adParamInput, 30, Email));
			Append(CreateParameter("WebSite", adVarChar, adParamInput, 30, WebSite));

			Append(CreateParameter("PerformerTitle", adVarChar, adParamInput, 30, PerformerTitle));
			Append(CreateParameter("PerformerName", adVarChar, adParamInput, 30, PerformerName));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {	
	Connect.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Компанія з таким кодом вже є")
}%>
