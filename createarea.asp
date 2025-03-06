<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2;
if (!Authorized) Message.Write(2, "Помилка авторизації");

with (Request) {
	var SortCode = Form("SortCode"),
	AreaName     = Form("AreaName");
}

try {
	Solaren.SetCmd("NewArea");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("SortCode", adTinyInt, adParamInput, 10, SortCode));
			Append(CreateParameter("AreaName", adVarChar, adParamInput, 20, AreaName));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Connect.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Район з таким номером вже є");
}%>
