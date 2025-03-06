<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<%
var Authorized = User.RoleId > 0 && User.RoleId < 3,
QueryName     = Request.QueryString("QueryName"),
JsonResponse  = '[{"ContractId":0}]';

if (Authorized) {
	try {
		Solaren.SetCmd("GetContractData");
		with (Cmd) {
			with (Parameters) {
				Append(CreateParameter("UserId", adInteger, adParamInput, 10, User.Id));
				Append(CreateParameter("QueryName", adVarChar, adParamInput, 10, QueryName));
				Append(CreateParameter("ContractData", adVarChar, adParamOutput, 8000, ""));
			} Execute(adExecuteNoRecords);
		}
		JsonResponse = Cmd.Parameters.Item("ContractData").value;
	} catch (ex) {
		Message.Write(3, Message.Error(ex));
	} finally {
		Connect.Close();
	}
}

with (Response) {
	CacheControl = "no-cache, no-store, must-revalidate";
	AddHeader("Content-Type","application/json");
	Write(JsonResponse);
}%>
