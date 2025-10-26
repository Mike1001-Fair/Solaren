<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/json.inc" -->
<% var Authorized = User.RoleId == 1,
Query = Solaren.Parse(),
ValidRequest = User.HasAccess(Authorized, "GET");

if (ValidRequest) {
	try {
		Solaren.SetCmd("GetCustomerData");
		with (Cmd) {
			with (Parameters) {
				Append(CreateParameter("QueryName", adVarChar, adParamInput, 10, Query.QueryName));
				Append(CreateParameter("CustomerData", adVarChar, adParamOutput, 8000, ""));
			}
			Execute(adExecuteNoRecords);
		}
		Json.data = Cmd.Parameters.Item("CustomerData").value;
	} catch (ex) {
		Json.error(ex, '[{"CustomerId":-2}]')
	} finally {
		Solaren.Close();
	}
} else {
	Json.data = '[{"CustomerId":0}]';
}
Json.write()%>

