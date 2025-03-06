<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<% var Authorized = Session("RoleId") == 1 || Session("RoleId") == 2;
if (!Authorized) Message.Write(2, "Помилка авторизації");

with (Request) {
	var IndicatorId = Form("IndicatorId"),
	ReportDate      = Form("ReportDate"),
	MeterId         = Form("MeterId"),
	RecVal          = Form("RecVal"),
	RetVal          = Form("RetVal"),
	PrevDate        = Form("PrevDate"),
	RecSaldo        = Form("RecSaldo"),
	RetSaldo        = Form("RetSaldo");
}

try {
	Solaren.SetCmd("UpdateIndicator");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adInteger, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("IndicatorId", adInteger, adParamInput,10, IndicatorId));
			Append(CreateParameter("ReportDate", adVarChar, adParamInput, 10, ReportDate));
			Append(CreateParameter("MeterId", adInteger, adParamInput, 10, MeterId));
			Append(CreateParameter("RecVal", adInteger, adParamInput, 10, RecVal));
			Append(CreateParameter("RetVal", adInteger, adParamInput, 10, RetVal));
			Append(CreateParameter("PrevDate", adVarChar, adParamInput, 10, PrevDate));
			Append(CreateParameter("RecSaldo", adInteger, adParamInput, 10, RecSaldo));
			Append(CreateParameter("RetSaldo", adInteger, adParamInput, 10, RetSaldo));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {	
	Connect.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Показники з такою датою вже є")
}%>
