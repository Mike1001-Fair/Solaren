<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") >= 0 || Session("RoleId") < 2;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
	var LocalityName = Form("LocalityName"),
	Deleted          = Form("Deleted") == "on";
}

try {
	Solaren.SetCmd("ListLocality");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("LocalityName", adVarChar, adParamInput, 10, LocalityName));
			Append(CreateParameter("Deleted", adBoolean, adParamInput, 1, Deleted));
		}
	}
	var rs = Cmd.Execute();
	Solaren.EOF(rs, 'Iнформацiю не знайдено');
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

with (Html) {
	SetHead("Населені пункти");
	WriteMenu(Session("RoleId"), 0);
}
Response.Write('<BODY CLASS="MainBody">\n' +
	'<H3 CLASS="H3Text">Населені пункти</H3>\n' +
	'<TABLE CLASS="InfoTable">\n' + 
	'<TR><TH>Тип</TH><TH>Назва</TH></TR>');
for (var i=0; !rs.EOF; i++) {
	Response.Write('<TR><TD ALIGN="LEFT">' + Html.LocalityType[rs.Fields("LocalityType")] + 
	Html.Write("TD","") + '<A href="editlocality.asp?LocalityId=' + rs.Fields("Id") + '">' + rs.Fields("LocalityName") + '</A></TD></TR>\n');
	rs.MoveNext();
} rs.Close(); Connect.Close();
Response.Write('<TR><TH ALIGN="LEFT" COLSPAN="2">Всього: ' + i + '</TH></TR>\n</TABLE></BODY></HTML>');%>