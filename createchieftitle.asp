<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/upsert.set" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2,
Form = Webserver.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("NewChiefTitle");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("Title1", adVarChar, adParamInput, 30, Form.Title1));
			Append(CreateParameter("Title2", adVarChar, adParamInput, 30, Form.Title2));
			Append(CreateParameter("Title3", adVarChar, adParamInput, 30, Form.Title3));
			Append(CreateParameter("RankId", adTinyInt, adParamInput, 1, Form.RankId));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		}
		Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").Value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Solaren.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Помилка");;
}%>

