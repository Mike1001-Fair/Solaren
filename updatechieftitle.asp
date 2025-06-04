<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/referer.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" --> 
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2;
User.ValidateAccess(Authorized, "POST");

with (Request) {
	var ChiefTitleId = Form("ChiefTitleId"),
	Title1   = Form("Title1"),
	Title2   = Form("Title2"),
	Title3   = Form("Title3"),
	RankId   = Form("RankId");
}

try {
	Solaren.SetCmd("UpdateChiefTitle");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("ChiefTitleId", adInteger, adParamInput, 10, ChiefTitleId));
			Append(CreateParameter("Title1", adVarChar, adParamInput, 30, Title1));
			Append(CreateParameter("Title2", adVarChar, adParamInput, 30, Title2));
			Append(CreateParameter("Title3", adVarChar, adParamInput, 30, Title3));
			Append(CreateParameter("RankId", adTinyInt, adParamInput, 1, RankId));
		} Execute(adExecuteNoRecords);
	} Solaren.Close();
	Message.Write(1, "");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}%>


