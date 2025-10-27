<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2;
if (!Authorized) Message.Write(2, "Помилка авторизації");

with (Request) {
	var SortCode = Form("SortCode"),
	AenName      = Form("AenName");
}

try {
	Solaren.SetCmd("NewAen");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("SortCode", adTinyInt, adParamInput, 10, SortCode));
			Append(CreateParameter("AenName", adVarChar, adParamInput, 20, AenName));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} Execute(adExecuteNoRecords);
	} Solaren.Close();
	Cmd.Parameters.Item("Done").Value ? Message.Write(1, "") : Message.Write(0, "РЕМ з таким номером вже є");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}%>


