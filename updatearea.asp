<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2;
User.ValidateAccess(Authorized, "POST");

with (Request) {
	var AreaId = Form("AreaId"),
	SortCode   = Form("SortCode"),
	AreaName   = Form("AreaName");
}

try {
	Solaren.SetCmd("UpdateArea");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("AreaId", adInteger, adParamInput, 10, AreaId));
			Append(CreateParameter("SortCode", adTinyInt, adParamInput, 10, SortCode));
			Append(CreateParameter("AreaName", adVarChar, adParamInput, 20, AreaName));
		} Execute(adExecuteNoRecords);
	} Solaren.Close();
	Message.Write(1, "");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}%>
