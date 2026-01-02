<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/upsert.set" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2;
User.CheckAccess(Authorized, "POST");

with (Request) {
	var DocId = Form("DocId"),
	SortCode  = Form("SortCode"),
	DocName   = Form("DocName");
}

try {
	Solaren.SetCmd("UpdateChiefDoc");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("DocId", adInteger, adParamInput, 10, DocId));
			Append(CreateParameter("SortCode", adTinyInt, adParamInput, 10, SortCode));
			Append(CreateParameter("DocName", adVarChar, adParamInput, 40, DocName));
		} Execute(adExecuteNoRecords);
	} Solaren.Close();
	Message.Write(1, "");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}%>

