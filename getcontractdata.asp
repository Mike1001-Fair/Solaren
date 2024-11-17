<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<% var RoleId = Session("RoleId"),
Authorized    = RoleId > 0 && RoleId < 3,
QueryName     = Request.QueryString("QueryName"),
JsonResponse  = '[{"ContractId":0}]';

if (Authorized) {
	try {
		Solaren.SetCmd("GetContractData");
		with (Cmd) {
			with (Parameters) {
				Append(CreateParameter("UserId", adInteger, adParamInput, 10, Session("UserId")));
				Append(CreateParameter("QueryName", adVarChar, adParamInput, 10, QueryName));
				Append(CreateParameter("ContractData", adVarChar, adParamOutput, 8000, ""));
			} Execute(adExecuteNoRecords);
		}
		JsonResponse = Cmd.Parameters.Item("ContractData").value;
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