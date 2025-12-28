<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="/Solaren/Include/api.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
Query = Solaren.Parse(),
ValidRequest = User.HasAccess(Authorized, "GET");

if (ValidRequest) {
	try {
		Solaren.SetCmd("GetLocalityData");
		with (Cmd) {
			with (Parameters) {
				Append(CreateParameter("QueryName", adVarChar, adParamInput, 10, Query.QueryName));
				Append(CreateParameter("LocalityData", adVarChar, adParamOutput, 8000, ""));
			}
			Execute(adExecuteNoRecords);
			Json.data = Parameters.Item("LocalityData").Value;
		}
	} catch (ex) {
		Json.error(ex, '[{"LocalityId":-2}]')
	} finally {
		Solaren.Close();
	}
} else {
	Json.data = '[{"LocalityId":0}]';
}
Json.write()%>

