<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Include/api.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
Query = Solaren.Parse(),
ValidRequest = User.CheckAccess(Authorized, "GET");

if (ValidRequest) {
	try {
		Solaren.SetCmd("GetLocalityInfo");
		with (Cmd) {
			with (Parameters) {
				Append(CreateParameter("LocalityId", adVarChar, adParamInput, 10, Query.LocalityId));
				Append(CreateParameter("LocalityInfo", adVarChar, adParamOutput, 100, ""));
			}
			Execute(adExecuteNoRecords);
		}
		Json.data = Cmd.Parameters.Item("LocalityInfo").Value;
	} catch (ex) {
		Json.error(ex, '[{"LocalityId":-2}]')
	} finally {
		Solaren.Close();
	}
} else {
	Json.data = '[{"LocalityId":0}]';
}
Json.write()%>

