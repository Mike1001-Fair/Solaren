<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Include/api.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
Query = Solaren.Parse(),
ValidRequest = User.HasAccess(Authorized, "GET");

if (ValidRequest) {
	try {
		Solaren.SetCmd("GetStreetInfo");
		with (Cmd) {
			with (Parameters) {
				Append(CreateParameter("StreetId", adVarChar, adParamInput, 10, Query.StreetId));
				Append(CreateParameter("StreetInfo", adVarChar, adParamOutput, 8000, ""));
			}
			Execute(adExecuteNoRecords);
		}
		Json.data = Cmd.Parameters.Item("StreetInfo").Value;
	} catch (ex) {
		Json.error(ex, '[{"StreetId":-2}]')
	} finally {
		Solaren.Close();
	}
} else {
	Json.data = '[{"StreetId":0}]';
}
Json.write()%>


