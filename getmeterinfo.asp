<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/json.inc" -->
<% var Authorized = User.RoleId > 0 && User.RoleId < 3,
Query = Solaren.Parse(),
ValidRequest = User.HasAccess(Authorized, "GET");

if (ValidRequest) {
	try {
		Solaren.SetCmd("GetMeterInfo");
		with (Cmd) {
			with (Parameters) {
				Append(CreateParameter("ReportDate", adVarChar, adParamInput, 10, Query.ReportDate));
				Append(CreateParameter("MeterId", adInteger, adParamInput, 10, Query.MeterId));
				Append(CreateParameter("MeterInfo", adVarChar, adParamOutput, 800, ""));
			}
			Execute(adExecuteNoRecords);
		}
		Json.data = Cmd.Parameters.Item("MeterInfo").value;
	} catch (ex) {
		Json.error(ex, '[{"MeterId":-2}]')
	} finally {
		Solaren.Close();
	}
} else {
	Json.data = '[{"MeterId":0}]';
}
Json.write()%>

