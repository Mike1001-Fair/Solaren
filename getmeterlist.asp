<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/json.inc" -->
<%
var Authorized = User.RoleId > 0 && User.RoleId < 3,
ContractId = Request.QueryString("ContractId");

if (Authorized) {
	try {
		Solaren.SetCmd("GetMeterList");
		with (Cmd) {
			with (Parameters) {
				Append(CreateParameter("ContractId", adInteger, adParamInput, 10, ContractId));
				Append(CreateParameter("MeterList", adVarChar, adParamOutput, 8000, ""));
			}
			Execute(adExecuteNoRecords);
		}
		Json.data = Cmd.Parameters.Item("MeterList").value;
	} catch (ex) {
		Json.data = '[{"MeterId":-2}]';
		Session("ScriptName") = Solaren.ScriptName;
		Session("SysMsg") = Message.Error(ex);
	} finally {
		Solaren.Close();
	}
} else {
	Json.data  = '[{"MeterId":0}]';
}
Json.write()%>
