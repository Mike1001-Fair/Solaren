<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<%
var Authorized = User.RoleId >= 0 && User.RoleId < 2,
JsonResponse  = '[{"LocalityId":0}]',
QueryName     = Request.QueryString("QueryName");

if (Authorized) {
	try {
		Solaren.SetCmd("GetLocalityData");
		with (Cmd) {
			with (Parameters) {
				Append(CreateParameter("QueryName", adVarChar, adParamInput, 10, QueryName));
				Append(CreateParameter("LocalityData", adVarChar, adParamOutput, 8000, ""));
			}
			Execute(adExecuteNoRecords);
			JsonResponse = Parameters.Item("LocalityData").value;
		}
	} catch (ex) {
		JsonResponse = '[{"LocalityId":-2}]';
		Session("ScriptName") = String(Request.ServerVariables("SCRIPT_NAME"));
		Session("SysMsg") = Message.Error(ex);
	} finally {
		Connect.Close();
	}
}

with (Response) {
	CacheControl = "no-cache, no-store, must-revalidate";
	AddHeader("Content-Type","application/json");
	Write(JsonResponse);
}%>
