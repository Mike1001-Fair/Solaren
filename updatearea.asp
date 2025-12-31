<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Include/upsert.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
Form = Solaren.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("UpdateArea");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("AreaId", adInteger, adParamInput, 10, Form.AreaId));
			Append(CreateParameter("SortCode", adTinyInt, adParamInput, 10, Form.SortCode));
			Append(CreateParameter("AreaName", adVarChar, adParamInput, 20, Form.AreaName));
		} Execute(adExecuteNoRecords);
	}
	Solaren.Close();
	Message.Write(1, "");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}%>

