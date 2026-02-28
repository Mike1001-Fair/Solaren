<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE VIRTUAL="Solaren/Set/upsert.set" -->
<% var Authorized = Session("RoleId") == 1,
Form = Webserver.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Db.SetCmd("UpdateFactVol");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adInteger, adParamInput, 10, User.Id));
			Append(CreateParameter("FactVolId", adInteger, adParamInput,10, Form.FactVolId));
			Append(CreateParameter("ContractId", adSmallInt, adParamInput, 10, Form.ContractId));
			Append(CreateParameter("BegDate", adVarChar, adParamInput, 10, Form.BegDate));
			Append(CreateParameter("EndDate", adVarChar, adParamInput, 10, Form.EndDate));
			Append(CreateParameter("RecVol", adInteger, adParamInput, 10, Form.RecVol));
			Append(CreateParameter("RetVol", adInteger, adParamInput, 10, Form.RetVol));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		}
		Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").Value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {	
	Db.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Такий запис вже є")
}%>