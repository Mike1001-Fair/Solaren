<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/json.inc" -->
<%
var Authorized = User.RoleId > 0 && User.RoleId < 3,
QueryName = Request.QueryString("QueryName");

if (Authorized) {
	try {
		Solaren.SetCmd("GetContractData");
		with (Cmd) {
			with (Parameters) {
				Append(CreateParameter("UserId", adInteger, adParamInput, 10, User.Id));
				Append(CreateParameter("QueryName", adVarChar, adParamInput, 10, QueryName));
				Append(CreateParameter("ContractData", adVarChar, adParamOutput, 8000, ""));
			} Execute(adExecuteNoRecords);
		}
		Json.data = Cmd.Parameters.Item("ContractData").value;
	} catch (ex) {
		Json.data = '[{"ContractId":-2}]';
		Session("ScriptName") = Solaren.ScriptName;
		Session("SysMsg") = Message.Error(ex);
	} finally {
		Solaren.Close();
	}
} else {
	Json.data = '[{"ContractId":0}]';
}
Json.write()%>