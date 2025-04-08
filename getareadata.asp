<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/json.inc" -->
<%
var Authorized = User.RoleId >= 0 && User.RoleId < 2,
QueryName = Request.QueryString("QueryName");

if (Authorized) {
	try {
		Solaren.SetCmd("GetAreaData");
		with (Cmd) {
			with (Parameters) {
				Append(CreateParameter("QueryName", adVarChar, adParamInput, 10, QueryName));
				Append(CreateParameter("AreaData", adVarChar, adParamOutput, 8000, ""));
			}
			Execute(adExecuteNoRecords);
		}
		Json.data = Cmd.Parameters.Item("AreaData").value;
	} catch (ex) {
		Json.data = '[{"AreaId":-2}]';
		Session("ScriptName") = Solaren.ScriptName;
		Session("SysMsg") = Message.Error(ex);
	} finally {
		Solaren.Close();
	}
} else {
	Json.data  = '[{"AreaId":0}]';
}
Json.write()%>
