<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1,
Contract = Solaren.Map(Request.Form);
User.ValidateAccess(Authorized, "POST");

try {
	Solaren.SetCmd("UpdateContract");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("ContractId", adInteger, adParamInput, 10, Contract.ContractId));
			Append(CreateParameter("CustomerId", adInteger, adParamInput, 10, Contract.CustomerId));
			Append(CreateParameter("PAN", adVarChar, adParamInput, 20, Contract.PAN));
			Append(CreateParameter("EICode", adVarChar, adParamInput, 20, Contract.EICode));
			Append(CreateParameter("Pay", adBoolean, adParamInput, 1, Contract.Pay == "on"));
			Append(CreateParameter("LocalityId", adInteger, adParamInput, 10, Contract.LocalityId));
			Append(CreateParameter("StreetId", adInteger, adParamInput, 10, Contract.StreetId));
			Append(CreateParameter("HouseId", adVarChar, adParamInput, 15, Contract.HouseId));
			Append(CreateParameter("ContractPower", adVarChar, adParamInput, 10, Contract.ContractPower));
			Append(CreateParameter("ExpDate", adVarChar, adParamInput, 10, Contract.ExpDate));
			Append(CreateParameter("ContractDate", adVarChar, adParamInput, 10, Contract.ContractDate));
			Append(CreateParameter("MfoCode", adVarChar, adParamInput, 10, Contract.MfoCode));
			Append(CreateParameter("BankAccount", adVarChar, adParamInput, 20, Contract.BankAccount));
			Append(CreateParameter("CardId", adVarChar, adParamInput, 20, Contract.CardId));
			Append(CreateParameter("BranchId", adInteger, adParamInput, 10, Contract.BranchId));
			Append(CreateParameter("AenId", adInteger, adParamInput, 10, Contract.AenId));
			Append(CreateParameter("OperatorId", adInteger, adParamInput, 10, Contract.OperatorId));
			Append(CreateParameter("TarifGroupId", adTinyInt, adParamInput, 1, Contract.TarifGroupId));
			Append(CreateParameter("Iban", adChar, adParamInput, 29, Contract.Iban));
			Append(CreateParameter("PerformerId", adInteger, adParamInput, 10, Contract.PerformerId));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} 
		Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {	
	Solaren.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Договiр з таким<br>особовим рахунком вже є")
}%>
