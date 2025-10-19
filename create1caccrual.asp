<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<% var Authorized = Session("RoleId") == 1;
Form = Solaren.Parse();
User.ValidateAccess(Authorized, "POST");

try {
	Solaren.SetCmd("List1Caccrual");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
		}
	}
	var rs = Solaren.Execute("List1Caccrual");
} catch (ex) {
	Message.Write(3, Message.Error(ex));
} finally {
	with (Response) {
		Buffer = true;
		CharSet  = Form.ReportCharSet;
		CodePage = Form.ReportCodePage;
		ContentType = "text/csv";
		AddHeader("Content-Disposition", "inline;filename=1caccrual.tsv");
		Write(rs.GetString());
		Flush();
	}
	rs.Close();
	Solaren.Close();
}%>

