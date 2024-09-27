<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
	var BranchName = Form("BranchName");
}

try {
	Solaren.SetCmd("ListBranch");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("BranchName", adVarChar, adParamInput, 10, BranchName));
		}
	}
	var rs = Cmd.Execute();
	Solaren.EOF(rs, 'Iнформацiю не знайдено');
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
} finally {
	with (Html) {
		SetHead("Список ЦОС");
		WriteScript();
		WriteMenu(Session("RoleId"), 0);
	}

	Response.Write('<BODY CLASS="MainBody">\n' +
		'<H3 CLASS="H3Text">Список ЦОС</H3>\n' +
		'<TABLE CLASS="InfoTable">\n' +
		'<TR><TH>№</TH><TH>Назва</TH><TH>Керiвник</TH><TH>Бухгалтер</TH></TR>\n');
	for (var i=0; !rs.EOF; i++) {
		Response.Write('<TR><TD ALIGN="CENTER">' + rs.Fields("SortCode") +
		Html.Write("TD","") + '<A href="editbranch.asp?BranchId=' + rs.Fields("BranchId") + '">' + rs.Fields("BranchName") + '</A></TD>' +
		Html.Write("TD","") + rs.Fields("ChiefName") +
		Html.Write("TD","") + rs.Fields("Accountant") + '</TD></TR>\n');
		rs.MoveNext();
	} rs.Close();Connect.Close();
	Response.Write('<TR><TH ALIGN="LEFT" COLSPAN="4">Всього: ' + i + '</TH></TR>\n</TABLE></BODY></HTML>')
}%>