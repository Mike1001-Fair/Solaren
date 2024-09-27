<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
	var SourceFile = Server.MapPath(Form("SourceFile"));
}

try {
	Solaren.SetCmd("TestIndicator");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("SourceFile", adVarChar, adParamInput, 100, SourceFile));			
			Append(CreateParameter("ErrStr", adVarChar, adParamInput, 10, ""));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} Execute(adExecuteNoRecords);
	} Connect.Close();
	Cmd.Parameters.Item("Done").value ? Solaren.SysMsg(1, "Помилок не виявлено") : Solaren.SysMsg(0, "Строка №" + Cmd.Parameters.Item("ErrStr").value);
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}%>