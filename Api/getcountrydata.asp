<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="/Solaren/Include/solaren.inc" -->
<!-- #INCLUDE VIRTUAL="/Solaren/Include/message.inc" -->
<!-- #INCLUDE VIRTUAL="/Solaren/Include/user.inc" -->
<!-- #INCLUDE VIRTUAL="/Solaren/Include/resource.inc" -->
<!-- #INCLUDE VIRTUAL="/Solaren/Include/json.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
Query = Solaren.Parse(),
ValidRequest = User.HasAccess(Authorized, "GET");

if (ValidRequest) {
	try {
		Solaren.SetCmd("GetCountryData");
		with (Cmd) {
			with (Parameters) {
				Append(CreateParameter("QueryName", adVarChar, adParamInput, 10, Query.QueryName));
				Append(CreateParameter("CountryData", adVarChar, adParamOutput, 8000, ""));
			}
			Execute(adExecuteNoRecords);
		}
		Json.data = Cmd.Parameters.Item("CountryData").Value;
	} catch (ex) {
		Json.error(ex, '[{"CountryId":-2}]')
	} finally {
		Solaren.Close();
	}
} else {
	Json.data = '[{"CountryId":0}]';
}
Json.write()%>
