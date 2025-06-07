<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/json.inc" -->
<%
var Authorized = User.RoleId >= 0 && User.RoleId < 2,
LocalityId = Request.QueryString("LocalityId");

if (Authorized) {
	try {
		Solaren.SetCmd("GetLocalityInfo");
		with (Cmd) {
			with (Parameters) {
				Append(CreateParameter("LocalityId", adVarChar, adParamInput, 10, LocalityId));
				Append(CreateParameter("LocalityInfo", adVarChar, adParamOutput, 100, ""));
			}
			Execute(adExecuteNoRecords);
		}
		Json.data = Cmd.Parameters.Item("LocalityInfo").value;
	} catch (ex) {
		Json.error(ex, '[{"LocalityId":-2}]')
	} finally {
		Solaren.Close();
	}
} else {
	Json.data = '[{"LocalityId":0}]';
}
Json.write()%>

