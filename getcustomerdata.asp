<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<%
var Authorized = User.RoleId == 1,
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
		Message.Write(3, Message.Error(ex));
	} finally {
		Solaren.Close();
	}
}

with (Response) {
	CacheControl = "no-cache, no-store, must-revalidate";
	AddHeader("Content-Type","application/json");
	Write(JsonResponse);
}%>
