<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<% var Authorized = Session("RoleId") > 0 && Session("RoleId") < 3,
ContractId = Request.QueryString("ContractId"),
JsonResponse = Authorized ? "" : '[{"MeterId":0}]';

if (Authorized) {
	try {
		Solaren.SetCmd("GetMeterList");
		with (Cmd) {
			with (Parameters) {
				Append(CreateParameter("ContractId", adInteger, adParamInput, 10, ContractId));
				Append(CreateParameter("MeterList", adVarChar, adParamOutput, 8000, ""));
			} Execute(adExecuteNoRecords);
		}
		JsonResponse = Cmd.Parameters.Item("MeterList").value;
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
