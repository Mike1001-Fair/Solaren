<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 0,
Form = Solaren.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("NewUser");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("LastName", adVarChar, adParamInput, 20, Form.LastName));
			Append(CreateParameter("FirstName", adVarChar, adParamInput, 20, Form.FirstName));
			Append(CreateParameter("MiddleName", adVarChar, adParamInput, 20, Form.MiddleName));
			Append(CreateParameter("Phone", adVarChar, adParamInput, 10, Form.Phone));
			Append(CreateParameter("UserName", adVarChar, adParamInput, 10, Form.UserName));
			Append(CreateParameter("Pswd", adVarChar, adParamInput, 10, Form.Pswd));
			Append(CreateParameter("RoleId", adVarChar, adParamInput, 10, Form.RoleId));
			Append(CreateParameter("CompanyId", adInteger, adParamInput, 10, Form.CompanyId));
			Append(CreateParameter("BranchId", adInteger, adParamInput, 10, Form.BranchId));
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