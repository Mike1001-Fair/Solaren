<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<% var Authorized = Session("RoleId") == 2;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
	var ReportDate = Form("ReportDate"),
	MeterId        = Form("MeterId"),
	RecVal         = Form("RecVal"),
	RetVal         = Form("RetVal"),
	PrevDate       = Form("PrevDate"),
	RecSaldo       = Form("RecSaldo"),
	RetSaldo       = Form("RetSaldo");
}

try {
	Solaren.SetCmd("NewIndicator");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adInteger, adParamInput, 10, Session("UserId")));
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
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
} finally {	
	Connect.Close();
	Done ? Solaren.SysMsg(1, "") : Solaren.SysMsg(0, "Показники з такою або<br>бiльш новою датою вже є")
}%>