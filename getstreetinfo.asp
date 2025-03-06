<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<% var RoleId = Session("RoleId"),
Authorized    = RoleId < 2,
JsonResponse  = '[{"StreetId":0}]',
StreetId      = Request.QueryString("StreetId");

if (Authorized) {
	try {
		Solaren.SetCmd("GetStreetInfo");
		with (Cmd) {
			with (Parameters) {
				Append(CreateParameter("StreetId", adVarChar, adParamInput, 10, StreetId));
				Append(CreateParameter("StreetInfo", adVarChar, adParamOutput, 8000, ""));
			} Execute(adExecuteNoRecords);
		}
		JsonResponse = Cmd.Parameters.Item("StreetInfo").value;
	} catch (ex) {
		Message.Write(3, Message.Error(ex));
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