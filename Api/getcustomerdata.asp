<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="/Solaren/Include/solaren.inc" -->
<!-- #INCLUDE VIRTUAL="/Solaren/Include/message.inc" -->
<!-- #INCLUDE VIRTUAL="/Solaren/Include/user.inc" -->
<!-- #INCLUDE VIRTUAL="/Solaren/Include/resource.inc" -->
<!-- #INCLUDE VIRTUAL="/Solaren/Include/json.inc" -->
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
		Json.data = Cmd.Parameters.Item("CustomerData").Value;
	} catch (ex) {
		Json.error(ex, '[{"CustomerId":-2}]')
	} finally {
		Solaren.Close();
	}
} else {
	Json.data = '[{"CustomerId":0}]';
}
Json.write()%>

