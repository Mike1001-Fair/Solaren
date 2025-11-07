<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
Form = Solaren.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("UpdateCompany");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("CompanyId", adInteger, adParamInput, 10, Form.CompanyId));
			Append(CreateParameter("CompanyName", adVarChar, adParamInput, 50, Form.CompanyName));
			Append(CreateParameter("CompanyCode", adVarChar, adParamInput, 10, Form.CompanyCode));
			Append(CreateParameter("ChiefId", adInteger, adParamInput, 10, Form.ChiefId));
			Append(CreateParameter("Accountant", adVarChar, adParamInput, 30, Form.Accountant));
			Append(CreateParameter("LogoType", adVarChar, adParamInput, 50, Form.LogoType));

			Append(CreateParameter("PostIndex", adVarChar, adParamInput, 10, Form.PostIndex));
			Append(CreateParameter("HouseId", adVarChar, adParamInput, 10, Form.HouseId));
			Append(CreateParameter("StreetId", adVarChar, adParamInput, 10, Form.StreetId));
			Append(CreateParameter("LocalityId", adInteger, adParamInput, 10, Form.LocalityId));
			Append(CreateParameter("RegionId", adInteger, adParamInput, 10, Form.RegionId));

			Append(CreateParameter("MfoCode", adVarChar, adParamInput, 10, Form.MfoCode));
			Append(CreateParameter("BankAccount", adVarChar, adParamInput, 30, Form.BankAccount));

			Append(CreateParameter("LicenseCode", adVarChar, adParamInput, 20, Form.LicenseCode));
			Append(CreateParameter("LicenseDate", adVarChar, adParamInput, 10, Form.LicenseDate));

			Append(CreateParameter("AccountantTaxCode", adVarChar, adParamInput, 10, Form.AccountantTaxCode));
			Append(CreateParameter("TaxCode", adVarChar, adParamInput, 15, Form.TaxCode));
			Append(CreateParameter("TaxAdminCode", adVarChar, adParamInput, 5, Form.TaxAdminCode));
			Append(CreateParameter("TaxStatus", adVarChar, adParamInput, 40, Form.TaxStatus));

			Append(CreateParameter("Phone", adVarChar, adParamInput, 10, Form.Phone));
			Append(CreateParameter("Email", adVarChar, adParamInput, 30, Form.Email));
			Append(CreateParameter("WebSite", adVarChar, adParamInput, 30, Form.WebSite));

			Append(CreateParameter("PerformerTitle", adVarChar, adParamInput, 30, Form.PerformerTitle));
			Append(CreateParameter("PerformerName", adVarChar, adParamInput, 30, Form.PerformerName));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} 
		Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").Value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {	
	Solaren.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Компанія з таким кодом вже є")
}%>

