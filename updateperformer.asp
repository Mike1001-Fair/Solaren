<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Message.Write(2, "Помилка авторизації");

with (Request) {
    var PerformerId = Form("PerformerId"),
	LastName    = Form("LastName"),
	FirstName   = Form("FirstName"),
	MiddleName  = Form("MiddleName"),
	Phone       = Form("Phone");
}

try {
	Solaren.SetCmd("UpdatePerformer");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("PerformerId", adInteger, adParamInput, 10, PerformerId));
			Append(CreateParameter("LastName", adVarChar, adParamInput, 20, LastName));
			Append(CreateParameter("FirstName", adVarChar, adParamInput, 20, FirstName));
			Append(CreateParameter("MiddleName", adVarChar, adParamInput, 20, MiddleName));
			Append(CreateParameter("Phone", adVarChar, adParamInput, 10, Phone));
		} Execute(adExecuteNoRecords);
	} Solaren.Close();
	Message.Write(1, "");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}%>
