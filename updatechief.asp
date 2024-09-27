<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/lib.inc" --> 
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

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
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("ChiefId", adInteger, adParamInput, 10, ChiefId));
			Append(CreateParameter("ChiefTitleId", adInteger, adParamInput, 10, ChiefTitleId));
			Append(CreateParameter("Name1", adVarChar, adParamInput, 30, Name1));
			Append(CreateParameter("Name2", adVarChar, adParamInput, 30, Name2));
			Append(CreateParameter("Name3", adVarChar, adParamInput, 30, Name3));
			Append(CreateParameter("ChiefDocId", adVarChar, adParamInput, 10, ChiefDocId));
			Append(CreateParameter("TrustedDocId", adVarChar, adParamInput, 10, TrustedDocId));
			Append(CreateParameter("TrustedDocDate", adVarChar, adParamInput, 10, TrustedDocDate));
		} Execute(adExecuteNoRecords);
	} Connect.Close();
	Solaren.SysMsg(1, "");
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}%>