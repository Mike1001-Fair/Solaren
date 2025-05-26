<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1,
Customer = Solaren.Map(Request.Form);
User.ValidateAccess(Authorized, "POST");

try {
	Solaren.SetCmd("UpdateCustomer");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("CustomerId", adInteger, adParamInput, 10, Customer.CustomerId));
			Append(CreateParameter("CustomerCode", adVarChar, adParamInput, 10, Customer.CustomerCode));
			Append(CreateParameter("Phone", adVarChar, adParamInput, 10, Customer.Phone));
			Append(CreateParameter("LastName", adVarChar, adParamInput, 20, Customer.LastName));
			Append(CreateParameter("FirstName", adVarChar, adParamInput, 20, Customer.FirstName));
			Append(CreateParameter("ThirdName", adVarChar, adParamInput, 20, Customer.ThirdName));
			Append(CreateParameter("HouseId", adVarChar, adParamInput, 20, Customer.HouseId));
			Append(CreateParameter("StreetId", adVarChar, adParamInput, 10, Customer.StreetId));
			Append(CreateParameter("LocalityId", adInteger, adParamInput, 10, Customer.LocalityId));
			Append(CreateParameter("AreaId", adVarChar, adParamInput, 10, Customer.AreaId));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {	
	Solaren.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Споживач з таким кодом вже є")
}%>
