<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/referer.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/json.inc" -->
<%
var Authorized = User.RoleId >= 0 && User.RoleId < 2,
StreetId = Request.QueryString("StreetId");

if (Authorized) {
	try {
		Solaren.SetCmd("GetStreetInfo");
		with (Cmd) {
			with (Parameters) {
				Append(CreateParameter("StreetId", adVarChar, adParamInput, 10, StreetId));
				Append(CreateParameter("StreetInfo", adVarChar, adParamOutput, 8000, ""));
			}
			Execute(adExecuteNoRecords);
		}
		Json.data = Cmd.Parameters.Item("StreetInfo").value;
	} catch (ex) {
		Json.error(ex, '[{"StreetId":-2}]')
	} finally {
		Solaren.Close();
	}
} else {
	Json.data = '[{"StreetId":0}]';
}
Json.write()%>


