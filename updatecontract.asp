<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
	var ContractId = Form("ContractId"),
	CustomerId     = Form("CustomerId"),
	PAN            = Form("PAN"),
	EICode         = Form("EICode"),
	Pay            = Form("Pay") == "on";
	LocalityId     = Form("LocalityId"),
	StreetId       = Form("StreetId"),
	HouseId        = Form("HouseId"),
	ContractPower  = Form("ContractPower"),
	ExpDate        = Form("ExpDate"),
	ContractDate   = Form("ContractDate"),
	MfoCode        = Form("MfoCode"),
	BankAccount    = Form("BankAccount"),
	CardId         = Form("CardId"),
	BranchId       = Form("BranchId"),
	AenId          = Form("AenId"),
	OperatorId     = Form("OperatorId"),
	TarifGroupId   = Form("TarifGroupId"),
	Iban           = Form("Iban"),
	PerformerId    = Form("PerformerId");
}

try {
	Solaren.SetCmd("UpdateContract");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("ContractId", adInteger, adParamInput, 10, ContractId));
			Append(CreateParameter("CustomerId", adInteger, adParamInput, 10, CustomerId));
			Append(CreateParameter("PAN", adVarChar, adParamInput, 20, PAN));
			Append(CreateParameter("EICode", adVarChar, adParamInput, 20, EICode));
			Append(CreateParameter("Pay", adBoolean, adParamInput, 1, Pay));
			Append(CreateParameter("LocalityId", adInteger, adParamInput, 10, LocalityId));
			Append(CreateParameter("StreetId", adInteger, adParamInput, 10, StreetId));
			Append(CreateParameter("HouseId", adVarChar, adParamInput, 15, HouseId));
			Append(CreateParameter("ContractPower", adVarChar, adParamInput, 10, ContractPower));
			Append(CreateParameter("ExpDate", adVarChar, adParamInput, 10, ExpDate));
			Append(CreateParameter("ContractDate", adVarChar, adParamInput, 10, ContractDate));
			Append(CreateParameter("MfoCode", adVarChar, adParamInput, 10, MfoCode));
			Append(CreateParameter("BankAccount", adVarChar, adParamInput, 20, BankAccount));
			Append(CreateParameter("CardId", adVarChar, adParamInput, 20, CardId));
			Append(CreateParameter("BranchId", adInteger, adParamInput, 10, BranchId));
			Append(CreateParameter("AenId", adInteger, adParamInput, 10, AenId));
			Append(CreateParameter("OperatorId", adInteger, adParamInput, 10, OperatorId));
			Append(CreateParameter("TarifGroupId", adTinyInt, adParamInput, 1, TarifGroupId));
			Append(CreateParameter("Iban", adChar, adParamInput, 29, Iban));
			Append(CreateParameter("PerformerId", adInteger, adParamInput, 10, PerformerId));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").value;
	}
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
} finally {	
	Connect.Close();
	Done ? Solaren.SysMsg(1, "") : Solaren.SysMsg(0, "Договiр з таким<br>особовим рахунком вже є")
}%>