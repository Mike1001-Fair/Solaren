<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<%
var Authorized = User.RoleId < 2,
JsonResponse   = '[{"StreetId":0}]',
QueryName      = Request.QueryString("QueryName");

if (Authorized) {
	try {
		Solaren.SetCmd("GetStreetData");
		with (Cmd) {
			with (Parameters) {
				Append(CreateParameter("QueryName", adVarChar, adParamInput, 10, QueryName));
				Append(CreateParameter("StreetData", adVarChar, adParamOutput, 8000, ""));
			} Execute(adExecuteNoRecords);
		}
		JsonResponse = Cmd.Parameters.Item("StreetData").value;
	} catch (ex) {
		JsonResponse = '[{"StreetId":-2}]';
		Session("ScriptName") = String(Request.ServerVariables("SCRIPT_NAME"));
		Session("SysMsg") = Solaren.GetErrMsg(ex);
	} finally {
		Connect.Close();
	}
}

with (Response) {
	CacheControl = "no-cache, no-store, must-revalidate";
	AddHeader("Content-Type","application/json");
	Write(JsonResponse);
}%>