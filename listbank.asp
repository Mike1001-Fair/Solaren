<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2,
Title = "Список банків",
BankName = Request.Form("BankName");

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");
try {
	Solaren.SetCmd("ListBank");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("BankName", adVarChar, adParamInput, 10, BankName));
		}
	}
	var rs = Solaren.Execute("ListBank", "Iнформацiю не знайдено");
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

with (Html) {
	SetHead(Title);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}

var ResponseText = '<BODY CLASS="MainBody">\n' +
	'<H3 CLASS="H3Text">' + Title + '</H3>\n' +
	'<TABLE CLASS="InfoTable">\n' +
	'<TR><TH>ЄДРПОУ</TH><TH>МФО</TH><TH>Найменування</TH></TR>\n';
for (var i=0; !rs.EOF; i++) {
	ResponseText += '<TR><TD>' + rs.Fields("EdrpoCode") +
	Html.Write("TD","") + rs.Fields("MfoCode") +
	Html.Write("TD","LEFT") + '<A href="editbank.asp?BankId=' + rs.Fields("Id") + '">' + rs.Fields("BankName") + '</A></TD></TR>\n';
	rs.MoveNext();
} rs.Close(); Connect.Close();
ResponseText += Html.GetFooterRow(3, i);
Response.Write(ResponseText)%>