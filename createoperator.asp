<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/upsert.set" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2;
if (!Authorized) Message.Write(2, "Помилка авторизації");

with (Request) {
	var SortCode = Form("SortCode"),
	EdrpoCode    = Form("EdrpoCode"),
	OperatorName = Form("OperatorName");
}

try {
	Solaren.SetCmd("NewOperator");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adInteger, adParamInput, 10, User.Id));
			Append(CreateParameter("SortCode", adTinyInt, adParamInput, 10, SortCode));
			Append(CreateParameter("EdrpoCode", adVarChar, adParamInput, 10, EdrpoCode));
			Append(CreateParameter("OperatorName", adVarChar, adParamInput, 30, OperatorName));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		}
		Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").Value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Solaren.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Такий оператор вже є");
}%>


