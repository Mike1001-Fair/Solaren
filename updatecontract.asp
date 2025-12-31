<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Include/upsert.inc" -->
<% var Authorized = User.RoleId == 1,
Form = Solaren.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("UpdateContract");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("ContractId", adInteger, adParamInput, 10, Form.ContractId));
			Append(CreateParameter("CustomerId", adInteger, adParamInput, 10, Form.CustomerId));
			Append(CreateParameter("PAN", adVarChar, adParamInput, 20, Form.PAN));
			Append(CreateParameter("EICode", adVarChar, adParamInput, 20, Form.EICode));
			Append(CreateParameter("Pay", adBoolean, adParamInput, 1, Form.Pay == "on"));
			Append(CreateParameter("LocalityId", adInteger, adParamInput, 10, Form.LocalityId));
			Append(CreateParameter("StreetId", adInteger, adParamInput, 10, Form.StreetId));
			Append(CreateParameter("HouseId", adVarChar, adParamInput, 15, Form.HouseId));
			Append(CreateParameter("ContractPower", adVarChar, adParamInput, 10, Form.ContractPower));
			Append(CreateParameter("ExpDate", adVarChar, adParamInput, 10, Form.ExpDate));
			Append(CreateParameter("ContractDate", adVarChar, adParamInput, 10, Form.ContractDate));
			Append(CreateParameter("MfoCode", adVarChar, adParamInput, 10, Form.MfoCode));
			Append(CreateParameter("BankAccount", adVarChar, adParamInput, 20, Form.BankAccount));
			Append(CreateParameter("CardId", adVarChar, adParamInput, 20, Form.CardId));
			Append(CreateParameter("BranchId", adInteger, adParamInput, 10, Form.BranchId));
			Append(CreateParameter("AenId", adInteger, adParamInput, 10, Form.AenId));
			Append(CreateParameter("OperatorId", adInteger, adParamInput, 10, Form.OperatorId));
			Append(CreateParameter("TarifGroupId", adTinyInt, adParamInput, 1, Form.TarifGroupId));
			Append(CreateParameter("Iban", adChar, adParamInput, 29, Form.Iban));
			Append(CreateParameter("PerformerId", adInteger, adParamInput, 10, Form.PerformerId));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} 
		Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").Value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {	
	Solaren.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Договiр з таким<br>особовим рахунком вже є")
}%>

