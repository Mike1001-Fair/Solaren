<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/json.inc" -->
<%
var Authorized = User.RoleId >= 0 && User.RoleId < 2,
Query = Solaren.Parse();

if (Authorized) {
	try {
		Solaren.SetCmd("GetCountryData");
		with (Cmd) {
			with (Parameters) {
				Append(CreateParameter("QueryName", adVarChar, adParamInput, 10, Query.QueryName));
				Append(CreateParameter("CountryData", adVarChar, adParamOutput, 8000, ""));
			}
			Execute(adExecuteNoRecords);
		}
		Json.data = Cmd.Parameters.Item("CountryData").value;
	} catch (ex) {
		Json.error(ex, '[{"CountryId":-2}]')
	} finally {
		Solaren.Close();
	}
} else {
	Json.data = '[{"CountryId":0}]';
}
Json.write()%>
