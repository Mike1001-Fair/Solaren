<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2,
JsonResponse = Authorized ? "" : '[{"LocalityId":0}]',
QueryName = Request.QueryString("QueryName");

if (Authorized) {
	try {
		Solaren.SetCmd("GetLocalityData");
		with (Cmd) {
			with (Parameters) {
				Append(CreateParameter("QueryName", adVarChar, adParamInput, 10, QueryName));
				Append(CreateParameter("LocalityData", adVarChar, adParamOutput, 8000, ""));
			} Execute(adExecuteNoRecords);
		}
		JsonResponse = Cmd.Parameters.Item("LocalityData").value;
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