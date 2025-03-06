<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<%
var Authorized = User.RoleId >= 0 && User.RoleId < 2,
JsonResponse = Authorized ? "" : '[{"CountryId":0}]';

with (Request) {
	var QueryName = QueryString("QueryName");
	Deleted       = QueryString("Deleted");
}

if (Authorized) {
	try {
		Solaren.SetCmd("GetCountryData");
		with (Cmd) {
			with (Parameters) {
				Append(CreateParameter("QueryName", adVarChar, adParamInput, 10, QueryName));
				Append(CreateParameter("CountryData", adVarChar, adParamOutput, 8000, ""));
			} Execute(adExecuteNoRecords);
		}
		JsonResponse = Cmd.Parameters.Item("CountryData").value;
	} catch (ex) {
		Message.Write(3, Message.Error(ex));
	} finally {
		Connect.Close();
	}
}

with (Response) {
	CacheControl = "no-cache, no-store, must-revalidate";
	AddHeader("Content-Type","application/json");
	Write(JsonResponse);
}%>