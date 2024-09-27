<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
    var ContractId = String(Form("ContractId")),
	MeterCode  = String(Form("MeterCode"));
}

try {
	Solaren.SetCmd("ListMeter");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("ContractId", adVarChar, adParamInput, 10, ContractId));
			Append(CreateParameter("MeterCode", adVarChar, adParamInput, 10, MeterCode));
		}
	}
	var rs = Cmd.Execute();
	Solaren.EOF(rs, 'Iнформацiю не знайдено');
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

with (Html) {
	SetHead("Список лiчильникiв");
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}

var ResponseText = '<BODY CLASS="MainBody">\n' +
	'<H3 CLASS="H3Text">Список лiчильникiв</H3>\n' +
	'<TABLE CLASS="InfoTable">\n' +
	'<TR><TH ROWSPAN="2">Рахунок</TH><TH ROWSPAN="2">Споживач</TH><TH COLSPAN="6">Лічильник</TH></TR>\n' + 
	'<TR><TH>Номер</TH><TH>Монтаж</TH><TH>Р</TH><TH>К</TH><TH>Прийом</TH><TH>Видача</TH></TR>\n';
for (var i=0; !rs.EOF; i++) {
	ResponseText += '<TR><TD>' + rs.Fields("PAN") +
	Html.Write("TD","LEFT") + rs.Fields("CustomerName") +
	Html.Write("TD","RIGHT") + '<A href="editmeter.asp?MeterId=' + rs.Fields("Id") + '">' + rs.Fields("Code") + '</A></TD>' +
	Html.Write("TD","") + rs.Fields("SetDate") +
	Html.Write("TD","") + rs.Fields("Capacity") +
	Html.Write("TD","") + rs.Fields("kTransForm") +
	Html.Write("TD","RIGHT") + rs.Fields("RecVal") +
	Html.Write("TD","RIGHT") + rs.Fields("RetVal") + '</TD></TR>\n';
	rs.MoveNext();
} rs.Close(); Connect.Close();
ResponseText += Html.GetFooterRow(8, i);
Response.Write(ResponseText)%>