<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2,
BegDate = Request.Form("BegDate");

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

try {
	Solaren.SetCmd("ListVz");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("BegDate", adVarChar, adParamInput, 10, BegDate));
		}
	}
	var rs = Cmd.Execute();
	Solaren.EOF(rs, 'Iнформацiю не знайдено');
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

with (Html) {
	SetHead("Ставка ВЗ");
	WriteMenu(Session("RoleId"), 0);
}

var ResponseText = '<BODY CLASS="MainBody">\n' +
	'<H3 CLASS="H3Text">Ставка ВЗ</H3>\n' +
	'<TABLE CLASS="InfoTable">\n' +
	'<TR><TH>Дiє з</TH><TH>по</TH><TH>Ставка</TH></TR>\n';

for (var i=0; !rs.EOF; i++) {
	ResponseText += '<TR><TD ALIGN="CENTER">' + rs.Fields("BegDate") +
	Html.Write("TD","") + rs.Fields("EndDate") +
	Html.Write("TD","RIGHT") + '<A HREF="editvz.asp?VzId=' + rs.Fields("Id") + '">' + rs.Fields("VzTax") + '</A></TD></TR>\n';
	rs.MoveNext();
} rs.Close();Connect.Close();
ResponseText += Html.GetFooterRow(3, i);
Response.Write(ResponseText)%>