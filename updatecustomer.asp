<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Message.Write(2, "Помилка авторизації");

with (Request) {
	var CustomerId = Form("CustomerId"),
	CustomerCode   = Form("CustomerCode"),
	Phone          = Form("Phone"),
	LastName       = Form("LastName"),
	FirstName      = Form("FirstName"),
	ThirdName      = Form("ThirdName"),
	HouseId        = Form("HouseId"),
	StreetId       = Form("StreetId"),
	LocalityId     = Form("LocalityId"),
	AreaId         = Form("AreaId");
}

try {
	Solaren.SetCmd("UpdateCustomer");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("CustomerId", adInteger, adParamInput, 10, CustomerId));
			Append(CreateParameter("CustomerCode", adVarChar, adParamInput, 10, CustomerCode));
			Append(CreateParameter("Phone", adVarChar, adParamInput, 10, Phone));
			Append(CreateParameter("LastName", adVarChar, adParamInput, 20, LastName));
			Append(CreateParameter("FirstName", adVarChar, adParamInput, 20, FirstName));
			Append(CreateParameter("ThirdName", adVarChar, adParamInput, 20, ThirdName));
			Append(CreateParameter("HouseId", adVarChar, adParamInput, 20, HouseId));
			Append(CreateParameter("StreetId", adVarChar, adParamInput, 10, StreetId));
			Append(CreateParameter("LocalityId", adInteger, adParamInput, 10, LocalityId));
			Append(CreateParameter("AreaId", adVarChar, adParamInput, 10, AreaId));
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
