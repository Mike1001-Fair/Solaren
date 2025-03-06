<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<%
var Authorized = User.RoleId > 0 && User.RoleId < 3,
JsonResponse  = '[{"MeterId":0}]',
ReportDate    = Request.QueryString("ReportDate"),
MeterId       = Request.QueryString("MeterId");

if (Authorized) {
	try {
		Solaren.SetCmd("GetMeterInfo");
		with (Cmd) {
			with (Parameters) {
				Append(CreateParameter("ReportDate", adVarChar, adParamInput, 10, ReportDate));
				Append(CreateParameter("MeterId", adInteger, adParamInput, 10, MeterId));
				Append(CreateParameter("MeterInfo", adVarChar, adParamOutput, 800, ""));
			} Execute(adExecuteNoRecords);
		}
		JsonResponse = Cmd.Parameters.Item("MeterInfo").value;
	} catch (ex) {
		Message.Write(3, Message.Error(ex));
	} finally {
		Connect.Close();
	}
}

with (Response) {
	CacheControl = "no-cache, no-store, must-revalidate";
	Expires = -9;
	AddHeader("Content-Type","application/json");
	Write(JsonResponse);
}%>

