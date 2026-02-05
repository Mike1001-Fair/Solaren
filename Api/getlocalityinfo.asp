<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/api.set" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
Query = Webserver.Parse(),
LocalityId = parseInt(Query.LocalityId, 10);
ValidRequest = User.CheckAccess(Authorized, "GET");

if (ValidRequest) {
	try {
		Db.SetCmd("GetLocalityInfo");
		with (Cmd) {
			with (Parameters) {
				Append(CreateParameter("LocalityId", adInteger, adParamInput, 10, LocalityId));
				Append(CreateParameter("LocalityInfo", adVarChar, adParamOutput, 100, ""));
			}
			Execute(adExecuteNoRecords);
		}
		Json.data = Cmd.Parameters.Item("LocalityInfo").Value;
	} catch (ex) {
		Json.error(ex, '[{"LocalityId":-2}]')
	} finally {
		Db.Close();
	}
} else {
	Json.data = '[{"LocalityId":0}]';
}
Json.write()%>

