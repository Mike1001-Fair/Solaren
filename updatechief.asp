<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE VIRTUAL="Solaren/Include/upsert.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2;
User.CheckAccess(Authorized, "POST");

with (Request) {
	var ChiefId    = Form("ChiefId"),
	ChiefTitleId   = Form("ChiefTitleId"),
	Name1          = Form("Name1"),
	Name2          = Form("Name2"),
	Name3          = Form("Name3"),
	ChiefDocId     = Form("ChiefDocId"),
	TrustedDocId   = Form("TrustedDocId"),
	TrustedDocDate = Form("TrustedDocDate");
}

try {
	Solaren.SetCmd("UpdateChief");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("ChiefId", adInteger, adParamInput, 10, ChiefId));
			Append(CreateParameter("ChiefTitleId", adInteger, adParamInput, 10, ChiefTitleId));
			Append(CreateParameter("Name1", adVarChar, adParamInput, 30, Name1));
			Append(CreateParameter("Name2", adVarChar, adParamInput, 30, Name2));
			Append(CreateParameter("Name3", adVarChar, adParamInput, 30, Name3));
			Append(CreateParameter("ChiefDocId", adVarChar, adParamInput, 10, ChiefDocId));
			Append(CreateParameter("TrustedDocId", adVarChar, adParamInput, 10, TrustedDocId));
			Append(CreateParameter("TrustedDocDate", adVarChar, adParamInput, 10, TrustedDocDate));
		} Execute(adExecuteNoRecords);
	} Solaren.Close();
	Message.Write(1, "");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}%>

