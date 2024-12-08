<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<%
var Authorized = User.RoleId > 0 && User.RoleId < 3,
JsonResponse  = '[{"MeterId":0}]',
ContractId    = Request.QueryString("ContractId");

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
}

with (Response) {
	CacheControl = "no-cache, no-store, must-revalidate";
	Expires = -9;
	AddHeader("Content-Type","application/json");
	Write(JsonResponse);
}%>
