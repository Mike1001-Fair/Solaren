<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Message.Write(2, "Помилка авторизації");

with (Request) {
	var SourceFile = Server.MapPath(Form("SourceFile"));
}

try {
	Db.SetCmd("TestIndicator");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("SourceFile", adVarChar, adParamInput, 100, SourceFile));			
			Append(CreateParameter("ErrStr", adVarChar, adParamInput, 10, ""));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} Execute(adExecuteNoRecords);
	} Db.Close();
	Cmd.Parameters.Item("Done").Value ? Message.Write(1, "Помилок не виявлено") : Message.Write(0, "Строка №" + Cmd.Parameters.Item("ErrStr").Value);
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}%>

