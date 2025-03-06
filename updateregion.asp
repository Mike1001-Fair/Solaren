<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2;
User.ValidateAccess(Authorized, "POST");

with (Request) {
    var RegionId   = Form("RegionId"),
	SortCode   = Form("SortCode"),
	RegionName = Form("RegionName");
}

try {
	Solaren.SetCmd("UpdateRegion");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("RegionId", adInteger, adParamInput, 10, RegionId));
			Append(CreateParameter("SortCode", adTinyInt, adParamInput, 10, SortCode));
			Append(CreateParameter("RegionName", adVarChar, adParamInput, 20, RegionName));
		} Execute(adExecuteNoRecords);
	} Connect.Close();
	Message.Write(1, "");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}%>
