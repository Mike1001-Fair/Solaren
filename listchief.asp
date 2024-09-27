<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2,
ChiefName = Request.Form("ChiefName");

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

try {
	Solaren.SetCmd("ListChief");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("ChiefName", adVarChar, adParamInput, 10, ChiefName));
		}
	}
	var rs = Cmd.Execute();
	Solaren.EOF(rs, 'Iнформацiю не знайдено');
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

with (Html) {
	SetHead("Керiвники");
	WriteMenu(Session("RoleId"), 0);
}

var ResponseText = '<BODY CLASS="MainBody">\n' +
	'<H3 CLASS="H3Text">Керiвники</H3>\n' +
	'<TABLE CLASS="InfoTable">\n' +
	'<TR><TH>Посада</TH><TH>ПIБ</TH></TR>\n';

for (var i=0; !rs.EOF; i++) {
	ResponseText += '<TR><TD>' + rs.Fields("Title1") + '</TD>' +
	Html.Write("TD","") + '<A href="editchief.asp?ChiefId=' + rs.Fields("Id") + '">' + rs.Fields("Name1") + '</A></TD></TR>\n';
	rs.MoveNext();
} rs.Close();Connect.Close();
ResponseText += Html.GetFooterRow(2, i);
Response.Write(ResponseText)%>