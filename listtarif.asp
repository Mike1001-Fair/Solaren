<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
    var GroupId   = Form("GroupId"),
	GroupName = Form("GroupName"),
	BegDate   = Form("BegDate");
}

try {
	Solaren.SetCmd("ListTarif");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("GroupId", adVarChar, adParamInput, 10, GroupId));
			Append(CreateParameter("BegDate", adVarChar, adParamInput, 10, BegDate));
		}
	}
	var rs = Cmd.Execute();
	Solaren.EOF(rs, 'Iнформацiю не знайдено');
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

with (Html) {
	SetHead("Список тарифiв");
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}

var ResponseText = '<BODY CLASS="MainBody">\n' +
	'<H3 CLASS="H3Text">Список тарифiв<SPAN>Група: ' + GroupName + '</SPAN></H3>\n' +
	'<TABLE CLASS="InfoTable">\n' +
	'<TR><TH COLSPAN="2">Дiє</TH><TH ROWSPAN="2">Дата вводу в<BR>експлуатацiю</TH><TH>Тариф</TH></TR>\n' +
	'<TR><TH>з</TH><TH>по</TH><TH>коп</TH>\n';
for (var i=0; !rs.EOF; i++) {
	ResponseText += '<TR><TD>' + rs.Fields("BegDate") + '</TD>' +
	Html.Write("TD","") + rs.Fields("EndDate") + 
	Html.Write("TD","") + rs.Fields("ExpDateBeg") + '-' + rs.Fields("ExpDateEnd") +
	Html.Write("TD","RIGHT") + '<A href="edittarif.asp?TarifId=' + rs.Fields("Id") + '">' + rs.Fields("Tarif").value.toDelimited(2) + '</A></TD></TR>\n';
	rs.MoveNext();
} rs.Close(); Connect.Close();
ResponseText += Html.GetFooterRow(4, i);
Response.Write(ResponseText)%>