<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
Region = Solaren.Map(Request.Form);
User.ValidateAccess(Authorized, "POST");

try {
	Solaren.SetCmd("UpdateRegion");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("RegionId", adInteger, adParamInput, 10, Region.RegionId));
			Append(CreateParameter("SortCode", adTinyInt, adParamInput, 10, Region.SortCode));
			Append(CreateParameter("RegionName", adVarChar, adParamInput, 20, Region.RegionName));
		}
		Execute(adExecuteNoRecords);
	}
	Solaren.Close();
	Message.Write(1, "");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}%>

