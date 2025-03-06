<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2;
if (!Authorized) Message.Write(2, "Помилка авторизації");

with (Request) {
	var Title1 = Form("Title1"),
	Title2     = Form("Title2"),
	Title3     = Form("Title3"),
	RankId     = Form("RankId");
}

try {
	Solaren.SetCmd("NewChiefTitle");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("Title1", adVarChar, adParamInput, 30, Title1));
			Append(CreateParameter("Title2", adVarChar, adParamInput, 30, Title2));
			Append(CreateParameter("Title3", adVarChar, adParamInput, 30, Title3));
			Append(CreateParameter("RankId", adTinyInt, adParamInput, 1, RankId));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} Execute(adExecuteNoRecords);
	} Connect.Close();
	Cmd.Parameters.Item("Done").value ? Message.Write(1, "") : Message.Write(0, "Помилка");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}%>
