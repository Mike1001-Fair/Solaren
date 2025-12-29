<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Include/api.inc" -->
<% var Authorized = User.RoleId > 0 && User.RoleId < 3,
Query = Solaren.Parse(),
ValidRequest = User.HasAccess(Authorized, "GET");

if (ValidRequest) {
	try {
		Solaren.SetCmd("GetContractData");
		with (Cmd) {
			with (Parameters) {
				Append(CreateParameter("UserId", adInteger, adParamInput, 10, User.Id));
				Append(CreateParameter("QueryName", adVarChar, adParamInput, 10, Query.QueryName));
				Append(CreateParameter("ContractData", adVarChar, adParamOutput, 8000, ""));
			}
			Execute(adExecuteNoRecords);
		}
		Json.data = Cmd.Parameters.Item("ContractData").Value;
	} catch (ex) {
		Json.error(ex, '[{"ContractId":-2}]')
	} finally {
		Solaren.Close();
	}
} else {
	Json.data = '[{"ContractId":0}]';
}
Json.write()%>
