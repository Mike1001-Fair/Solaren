<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/referer.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2;
if (!Authorized) Message.Write(2, "Помилка авторизації");

with (Request) {
	var AenId = Form("AenId"),
	SortCode  = Form("SortCode"),
	AenName   = Form("AenName");
}

try {
	Solaren.SetCmd("UpdateAen");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("AenId", adInteger, adParamInput, 10, AenId));
			Append(CreateParameter("SortCode", adTinyInt, adParamInput, 10, SortCode));
			Append(CreateParameter("AenName", adVarChar, adParamInput, 20, AenName));
		} Execute(adExecuteNoRecords);
	} Solaren.Close();
	Message.Write(1, "");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}%>

