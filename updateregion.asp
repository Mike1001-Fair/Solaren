<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/upsert.set" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
Form = Solaren.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("UpdateRegion");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("RegionId", adInteger, adParamInput, 10, Form.RegionId));
			Append(CreateParameter("SortCode", adTinyInt, adParamInput, 10, Form.SortCode));
			Append(CreateParameter("RegionName", adVarChar, adParamInput, 20, Form.RegionName));
		}
		Execute(adExecuteNoRecords);
	}
	Solaren.Close();
	Message.Write(1, "");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}%>

