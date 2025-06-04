<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/referer.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/json.inc" -->
<%
var Authorized = User.RoleId > 0 && User.RoleId < 3,
ReportDate = Request.QueryString("ReportDate"),
MeterId    = Request.QueryString("MeterId");

if (Authorized) {
	try {
		Solaren.SetCmd("GetMeterInfo");
		with (Cmd) {
			with (Parameters) {
				Append(CreateParameter("ReportDate", adVarChar, adParamInput, 10, ReportDate));
				Append(CreateParameter("MeterId", adInteger, adParamInput, 10, MeterId));
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

