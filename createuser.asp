<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/upsert.set" -->
<% var Authorized = User.RoleId == 0,
Form = Webserver.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Db.SetCmd("NewUser");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("LastName", adVarChar, adParamInput, 20, Form.LastName));
			Append(CreateParameter("FirstName", adVarChar, adParamInput, 20, Form.FirstName));
			Append(CreateParameter("MiddleName", adVarChar, adParamInput, 20, Form.MiddleName));
			Append(CreateParameter("Phone", adVarChar, adParamInput, 10, Form.Phone));
			Append(CreateParameter("UserName", adVarChar, adParamInput, 20, Form.UserName));
			Append(CreateParameter("Pswd", adVarChar, adParamInput, 20, Form.Pswd));
			Append(CreateParameter("RoleId", adVarChar, adParamInput, 10, Form.RoleId));
			Append(CreateParameter("CompanyId", adInteger, adParamInput, 10, Form.CompanyId));
			Append(CreateParameter("BranchId", adInteger, adParamInput, 10, Form.BranchId));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		}
		Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").Value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Db.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Користувач з таким логіном вже є");
}%>