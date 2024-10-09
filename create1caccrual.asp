<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
    var ReportCharSet  = Form("ReportCharSet"),
	ReportCodePage = Form("ReportCodePage");
}

try {
	Solaren.SetCmd("List1Caccrual");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
		}
	}
	var rs = Solaren.Execute("List1Caccrual", "Iнформацiю не знайдено");
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex));
} finally {
	with (Response) {
		Buffer = true;
		CharSet  = ReportCharSet;
		CodePage = ReportCodePage;
		ContentType = "text/csv";
		AddHeader("Content-Disposition", "inline;filename=1caccrual.tsv");
		Write(rs.GetString());
		Flush();
	}
	rs.Close();
	Connect.Close();
}%>