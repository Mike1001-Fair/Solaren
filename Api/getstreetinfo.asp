<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/api.set" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
Query = Webserver.Parse(),
StreetId = parseInt(Query.StreetId, 10);
ValidRequest = User.HasAccess(Authorized, "GET");

if (ValidRequest) {
	try {
		Db.SetCmd("GetStreetInfo");
		with (Cmd) {
			with (Parameters) {
				Append(CreateParameter("StreetId", adInteger, adParamInput, 10, StreetId));
				Append(CreateParameter("StreetInfo", adVarChar, adParamOutput, 8000, ""));
			}
			Execute(adExecuteNoRecords);
		}
		Json.data = Cmd.Parameters.Item("StreetInfo").Value;
	} catch (ex) {
		Json.error(ex, '[{"StreetId":-2}]')
	} finally {
		Db.Close();
	}
} else {
	Json.data = '[{"StreetId":0}]';
}
Json.write()%>


