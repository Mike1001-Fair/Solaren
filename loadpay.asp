<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Message.Write(2, "Помилка авторизації");

var SourceFile = Server.MapPath(Request("SourceFile"));
try {
	Solaren.SetCmd("LoadPay");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("SourceFile", adVarChar, adParamInput, 100, SourceFile));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} Execute(adExecuteNoRecords);
	} Solaren.Close();
	Cmd.Parameters.Item("Done").value ? Message.Write(1, "") : Message.Write(0, "Файл iмпорту не знайдено");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}%>

