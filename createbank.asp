<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" --> 
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2;
User.ValidateAccess(Authorized, "POST");

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
	Message.Write(3, Message.Error(ex))
} finally {	
	Connect.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Банк з таким кодом МФО вже є");
}%>
