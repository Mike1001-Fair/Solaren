<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/upsert.set" -->
<% var Authorized = Session("RoleId") == 1;
Form = Webserver.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Db.SetCmd("List1Cagent");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
		}
	}
	var rs = Db.Execute("List1Cagent");
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
	Db.Close()
}%>

