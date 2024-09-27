<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<% var Authorized = Session("RoleId") == 0;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

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
	Solaren.SetCmd("UpdateUser");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adInteger, adParamInput, 10, UserId));
			Append(CreateParameter("LastName", adVarChar, adParamInput, 20, LastName));
			Append(CreateParameter("FirstName", adVarChar, adParamInput, 20, FirstName));
			Append(CreateParameter("MiddleName", adVarChar, adParamInput, 20, MiddleName));
			Append(CreateParameter("Phone", adVarChar, adParamInput, 10, Phone));
			Append(CreateParameter("LoginId", adVarChar, adParamInput, 10, LoginId));
			Append(CreateParameter("Pswd", adVarChar, adParamInput, 10, Pswd));
			Append(CreateParameter("RoleId", adVarChar, adParamInput, 10, RoleId));
			Append(CreateParameter("CompanyId", adInteger, adParamInput, 10, CompanyId));
			Append(CreateParameter("BranchId", adInteger, adParamInput, 10, BranchId));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").value;
	}
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex));
} finally {
	Connect.Close();
	Done ? Solaren.SysMsg(1, "") : Solaren.SysMsg(0, "Користувач з таким логіном вже є");
}%>