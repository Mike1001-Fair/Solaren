<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/upsert.set" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2;
if (!Authorized) Message.Write(2, "Помилка авторизації");

with (Request) {
	var ChiefTitleId = Form("ChiefTitleId"),
	Name1            = Form("Name1"),
	Name2            = Form("Name2"),
	Name3            = Form("Name3"),
	ChiefDocId       = Form("ChiefDocId"),
	TrustedDocId     = Form("TrustedDocId"),
	TrustedDocDate   = Form("TrustedDocDate");
}

try {
	Solaren.SetCmd("NewChief");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adInteger, adParamInput, 10, User.Id));
			Append(CreateParameter("ChiefTitleId", adInteger, adParamInput, 10, ChiefTitleId));
			Append(CreateParameter("Name1", adVarChar, adParamInput, 30, Name1));
			Append(CreateParameter("Name2", adVarChar, adParamInput, 30, Name2));
			Append(CreateParameter("Name3", adVarChar, adParamInput, 30, Name3));
			Append(CreateParameter("ChiefDocId", adVarChar, adParamInput, 10, ChiefDocId));
			Append(CreateParameter("TrustedDocId", adVarChar, adParamInput, 10, TrustedDocId));
			Append(CreateParameter("TrustedDocDate", adVarChar, adParamInput, 10, TrustedDocDate));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").Value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Solaren.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Такий керівник вже є");
}%>

