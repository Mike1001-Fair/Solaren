<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<% var RoleId = Session("RoleId"),
Authorized    = RoleId < 2,
LocalityId    = Request.QueryString("LocalityId"),
JsonResponse  = '[{"LocalityId":0}]';

if (Authorized) {
	try {
		Solaren.SetCmd("GetLocalityInfo");
		with (Cmd) {
			with (Parameters) {
				Append(CreateParameter("LocalityId", adVarChar, adParamInput, 10, LocalityId));
				Append(CreateParameter("LocalityInfo", adVarChar, adParamOutput, 100, ""));
			} Execute(adExecuteNoRecords);
		}
		JsonResponse = Cmd.Parameters.Item("LocalityInfo").value;
	} catch (ex) {
		Message.Write(3, Message.Error(ex));
	} finally {
		Solaren.Close();
	}
} else {
	Session("SysMsg") = "Помилка авторизації";
}

with (Response) {
	CacheControl = "no-cache, no-store, must-revalidate";
	AddHeader("Content-Type","application/json");
	Write(JsonResponse);
}%>
