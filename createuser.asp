<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 0;
User.ValidateAccess(Authorized, "POST");

with (Request) {
    var UserId     = Form("UserId"),
	LastName   = Form("LastName"),
	FirstName  = Form("FirstName"),
	MiddleName = Form("MiddleName"),
	Phone      = Form("Phone"),
	LoginId    = Form("LoginId"),
	Pswd       = Form("Pswd"),
	RoleId     = Form("RoleId"),
	CompanyId  = Form("CompanyId"),
	BranchId   = Form("BranchId");
}

try {
	Solaren.SetCmd("NewUser");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("LastName", adVarChar, adParamInput, 20, LastName));
			Append(CreateParameter("FirstName", adVarChar, adParamInput, 20, FirstName));
			Append(CreateParameter("MiddleName", adVarChar, adParamInput, 20, MiddleName));
			Append(CreateParameter("Phone", adVarChar, adParamInput, 10, Phone));
			Append(CreateParameter("LoginId", adVarChar, adParamInput, 10, LoginId));
			Append(CreateParameter("Pswd", adVarChar, adParamInput, 10, Pswd));
			Append(CreateParameter("RoleId", adVarChar, adParamInput, 3, RoleId));
			Append(CreateParameter("CompanyId", adInteger, adParamInput, 10, CompanyId));
			Append(CreateParameter("BranchId", adInteger, adParamInput, 10, BranchId));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Solaren.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Користувач з таким логіном вже є");
}%>
