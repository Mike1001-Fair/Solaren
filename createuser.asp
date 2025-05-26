<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 0,
Person = Solaren.Map(Request.Form);
User.ValidateAccess(Authorized, "POST");

try {
	Solaren.SetCmd("NewUser");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("LastName", adVarChar, adParamInput, 20, Person.LastName));
			Append(CreateParameter("FirstName", adVarChar, adParamInput, 20, Person.FirstName));
			Append(CreateParameter("MiddleName", adVarChar, adParamInput, 20, Person.MiddleName));
			Append(CreateParameter("Phone", adVarChar, adParamInput, 10, Person.Phone));
			Append(CreateParameter("LoginId", adVarChar, adParamInput, 10, Person.LoginId));
			Append(CreateParameter("Pswd", adVarChar, adParamInput, 10, Person.Pswd));
			Append(CreateParameter("RoleId", adVarChar, adParamInput, 3, Person.RoleId));
			Append(CreateParameter("CompanyId", adInteger, adParamInput, 10, Person.CompanyId));
			Append(CreateParameter("BranchId", adInteger, adParamInput, 10, Person.BranchId));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		}
		Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Solaren.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Користувач з таким логіном вже є");
}%>
