<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = Session("RoleId") == 1 || Session("RoleId") == 2;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

try {
	Solaren.SetCmd("ListNoVol");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("OperDate", adVarChar, adParamInput, 10, Session("Operdate")));
		}
	}
	var rs = Cmd.Execute();
	Solaren.EOF(rs, 'Iнформацiю не знайдено');
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

with (Html) {
	SetHead("Звіт");
	WriteMenu(Session("RoleId"), 0)
}

var ResponseText = '<BODY CLASS="MainBody">\n' +
	'<H3 CLASS="H3Text">Договора без обсягiв<SPAN>' + Month.GetPeriod(Session("OperMonth"), 0) + '</SPAN></H3>\n' +
	'<TABLE CLASS="InfoTable">\n' +
	'<TR><TH>Споживач</TH><TH>Рахунок</TH><TH>ЦОС</TH></TR>\n';
for (var i=0; !rs.EOF; i++) {
	ResponseText += '<TR><TD>' + rs.Fields("CustomerName") +
	Html.Write("TD","") + rs.Fields("ContractPAN") +
	Html.Write("TD","") + rs.Fields("BranchName") + '</TD></TR>\n';
	rs.MoveNext();
} rs.Close(); Connect.Close();
ResponseText += Html.GetFooterRow(3, i);
Response.Write(ResponseText)%>