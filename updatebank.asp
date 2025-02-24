<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2;
User.ValidateAccess(Authorized, "POST");

with (Request) {
	var BankId = Form("BankId"),
	EdrpoCode  = Form("EdrpoCode"),
	MfoCode    = Form("MfoCode"),
	BankName   = Form("BankName");
}

try {
	Solaren.SetCmd("UpdateBank");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("BankId", adInteger, adParamInput, 10, BankId));
			Append(CreateParameter("EdrpoCode", adVarChar, adParamInput, 10, EdrpoCode));
			Append(CreateParameter("MfoCode", adVarChar, adParamInput, 10, MfoCode));
			Append(CreateParameter("BankName", adVarChar, adParamInput, 30, BankName));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} Execute();
		var Done = Parameters.Item("Done").value;
	}
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
} finally {	
	Connect.Close();
	Done ? Solaren.SysMsg(1, "") : Solaren.SysMsg(0, "Такий банк вже є");
}%>