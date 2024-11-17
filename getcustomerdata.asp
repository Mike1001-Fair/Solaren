<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<% var RoleId = Session("RoleId"),
Authorized    = RoleId > 0 && RoleId < 3,
QueryName     = Request.QueryString("QueryName"),
JsonResponse  = '[{"CustomerId":0}]';

if (Authorized) {
	try {
		Solaren.SetCmd("GetCustomerData");
		with (Cmd) {
			with (Parameters) {
				Append(CreateParameter("QueryName", adVarChar, adParamInput, 10, QueryName));
				Append(CreateParameter("CustomerData", adVarChar, adParamOutput, 8000, ""));
			} Execute(adExecuteNoRecords);
		}
		JsonResponse = Cmd.Parameters.Item("CustomerData").value;
	} catch (ex) {
		Solaren.SysMsg(3, Solaren.GetErrMsg(ex));
	} finally {
		Connect.Close();
	}
}

with (Response) {
	CacheControl = "no-cache, no-store, must-revalidate";
	AddHeader("Content-Type","application/json");
	Write(JsonResponse);
}%>