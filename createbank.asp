<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/lib.inc" --> 
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
	var EdrpoCode = Form("EdrpoCode"),
	MfoCode       = Form("MfoCode"),
	BankName      = Form("BankName");
}

try {
	Solaren.SetCmd("NewBank");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("EdrpoCode", adVarChar, adParamInput, 10, EdrpoCode));
			Append(CreateParameter("MfoCode", adVarChar, adParamInput, 10, MfoCode));
			Append(CreateParameter("BankName", adVarChar, adParamInput, 30, BankName));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").value;
	}
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
} finally {	
	Connect.Close();
	Done ? Solaren.SysMsg(1, "") : Solaren.SysMsg(0, "Банк з таким кодом МФО вже є");
}%>