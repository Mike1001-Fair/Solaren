<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<% var Authorized = Session("RoleId") >= 0 || Session("RoleId") < 2;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
	var LocalityId = Form("LocalityId"),
	LocalityType   = Form("LocalityType"),
	LocalityName   = Form("LocalityName");
}

try {
	Solaren.SetCmd("UpdateLocality");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("LocalityId", adInteger, adParamInput, 10, LocalityId));
			Append(CreateParameter("LocalityType", adTinyInt, adParamInput, 10, LocalityType));
			Append(CreateParameter("LocalityName", adVarChar, adParamInput, 30, LocalityName));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").value;
	}
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
} finally {	
	Connect.Close();
	Done ? Solaren.SysMsg(1, "") : Solaren.SysMsg(0, "Такий пункт вже є");
}%>