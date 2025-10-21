<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/json.inc" -->
<%
var Authorized = User.RoleId >= 0 && User.RoleId < 2,
Query = Solaren.Parse();

if (User.ValidateAccess(Authorized, "GET")) {
	try {
		Solaren.SetCmd("GetStreetData");
		with (Cmd) {
			with (Parameters) {
				Append(CreateParameter("QueryName", adVarChar, adParamInput, 10, Query.QueryName));
				Append(CreateParameter("StreetData", adVarChar, adParamOutput, 8000, ""));
			}
			Execute(adExecuteNoRecords);
			Json.data = Parameters.Item("StreetData").value;
		}
	} catch (ex) {
		Json.error(ex, '[{"StreetId":-2}]')
	} finally {
		Solaren.Close();
	}
} else {
	Json.data = '[{"StreetId":0}]';
}
Json.write()%>


