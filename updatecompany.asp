<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/referer.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
Company = Solaren.Map(Request.Form);
User.ValidateAccess(Authorized, "POST");

try {
	Solaren.SetCmd("UpdateCompany");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("CompanyId", adInteger, adParamInput, 10, Company.CompanyId));
			Append(CreateParameter("CompanyName", adVarChar, adParamInput, 50, Company.CompanyName));
			Append(CreateParameter("CompanyCode", adVarChar, adParamInput, 10, Company.CompanyCode));
			Append(CreateParameter("ChiefId", adInteger, adParamInput, 10, Company.ChiefId));
			Append(CreateParameter("Accountant", adVarChar, adParamInput, 30, Company.Accountant));
			Append(CreateParameter("LogoType", adVarChar, adParamInput, 50, Company.LogoType));

			Append(CreateParameter("PostIndex", adVarChar, adParamInput, 10, Company.PostIndex));
			Append(CreateParameter("HouseId", adVarChar, adParamInput, 10, Company.HouseId));
			Append(CreateParameter("StreetId", adVarChar, adParamInput, 10, Company.StreetId));
			Append(CreateParameter("LocalityId", adInteger, adParamInput, 10, Company.LocalityId));
			Append(CreateParameter("RegionId", adInteger, adParamInput, 10, Company.RegionId));

			Append(CreateParameter("MfoCode", adVarChar, adParamInput, 10, Company.MfoCode));
			Append(CreateParameter("BankAccount", adVarChar, adParamInput, 30, Company.BankAccount));

			Append(CreateParameter("LicenseCode", adVarChar, adParamInput, 20, Company.LicenseCode));
			Append(CreateParameter("LicenseDate", adVarChar, adParamInput, 10, Company.LicenseDate));

			Append(CreateParameter("AccountantTaxCode", adVarChar, adParamInput, 10, Company.AccountantTaxCode));
			Append(CreateParameter("TaxCode", adVarChar, adParamInput, 15, Company.TaxCode));
			Append(CreateParameter("TaxAdminCode", adVarChar, adParamInput, 5, Company.TaxAdminCode));
			Append(CreateParameter("TaxStatus", adVarChar, adParamInput, 40, Company.TaxStatus));

			Append(CreateParameter("Phone", adVarChar, adParamInput, 10, Company.Phone));
			Append(CreateParameter("Email", adVarChar, adParamInput, 30, Company.Email));
			Append(CreateParameter("WebSite", adVarChar, adParamInput, 30, Company.WebSite));

			Append(CreateParameter("PerformerTitle", adVarChar, adParamInput, 30, Company.PerformerTitle));
			Append(CreateParameter("PerformerName", adVarChar, adParamInput, 30, Company.PerformerName));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {	
	Solaren.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Компанія з таким кодом вже є")
}%>

