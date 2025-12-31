<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Include/upsert.inc" -->
<% var Authorized = Session("RoleId") == 1;
Form = Solaren.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("List1Cagent");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
		}
	}
	var rs = Solaren.Execute("List1Cagent");
} catch (ex) {
	Message.Write(3, Message.Error(ex));
} finally {
	with (Response) {
		//Clear();
		//Buffer   = true;
		CharSet  = Form.ReportCharSet;
		CodePage = Form.ReportCodePage;
		ContentType = "text/csv";
		AddHeader("Content-Disposition", "attachment;filename=1cagent.tsv");
		Write(rs.GetString());
	}
	rs.Close();
	Solaren.Close()
}%>

