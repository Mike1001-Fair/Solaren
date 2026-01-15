<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/api.set" -->
<% var Authorized = User.RoleId > 0 && User.RoleId < 3,
Query = Webserver.Parse(),
ValidRequest = User.HasAccess(Authorized, "GET");

if (ValidRequest) {
	try {
		Solaren.SetCmd("GetMeterList");
		with (Cmd) {
			with (Parameters) {
				Append(CreateParameter("ContractId", adInteger, adParamInput, 10, Query.ContractId));
				Append(CreateParameter("MeterList", adVarChar, adParamOutput, 8000, ""));
			}
			Execute(adExecuteNoRecords);
		}
		Json.data = Cmd.Parameters.Item("MeterList").Value;
	} catch (ex) {
		Json.error(ex, '[{"MeterId":-2}]')
	} finally {
		Solaren.Close();
	}
} else {
	Json.data = '[{"MeterId":0}]';
}
Json.write()%>

