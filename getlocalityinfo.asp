<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2,
LocalityId = Request.QueryString("LocalityId"),
JsonResponse = Authorized ? "" : '[{"LocalityId":0}]';

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
		Solaren.SysMsg(3, Solaren.GetErrMsg(ex));
	} finally {
		Connect.Close();
	}
} else {
	Session("SysMsg") = "Помилка авторизації";
}

with (Response) {
	CacheControl = "no-cache, no-store, must-revalidate";
	AddHeader("Content-Type","application/json");
	Write(JsonResponse);
}%>