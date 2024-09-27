<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<% var Authorized = Session("RoleId") > 0 && Session("RoleId") < 3,
JsonResponse = Authorized ? "" : '[{"MeterId":0}]';

with (Request) {
	var MeterId = QueryString("MeterId"),
	ReportDate  = QueryString("ReportDate");
}

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
		Solaren.SysMsg(3, Solaren.GetErrMsg(ex));
	} finally {
		Connect.Close();
	}
} else {
	Session("SysMsg") = "Помилка авторизації";
}

with (Response) {
	CacheControl = "no-cache, no-store, must-revalidate";
	Expires = -9;
	AddHeader("Content-Type","application/json");
	Write(JsonResponse);
}%>