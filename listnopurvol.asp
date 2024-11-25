<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/money.inc" -->

<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

try {
	Solaren.SetCmd("ListNoPurVol");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("OperDate", adVarChar, adParamInput, 10, Html.Date[1]));
		}
	}
	var rs = Cmd.Execute();
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

if (rs.EOF) {
	Solaren.SysMsg(1, "Помилок не виявлено");
} else {
	var Period = Html.GetMonth(1).split("-").reverse().join("-"),
	ResponseText = '<BODY CLASS="MainBody">\n' +
	'<H3 CLASS="H3Text">Перевiрка обсягiв<SPAN>перiод:' + Period + '</SPAN></H3>\n' +
	'<TABLE CLASS="InfoTable">\n' +
	'<TR><TH>Споживач</TH><TH>Рахунок</TH><TH>З</TH><TH>По</TH></TH><TH>Прийом</TH><TH>Видача</TH><TH>ЦОС</TH></TR>\n';

	with (Html) {
		SetHead("Обсяги");
		WriteMenu(Session("RoleId"), 0);
	}

	for (var i=0; !rs.EOF; i++) {
		ResponseText += '<TR><TD>' + rs.Fields("CustomerName") + 
		Html.Write("TD","") + rs.Fields("ContractPAN") +
		Html.Write("TD","") + rs.Fields("BegDate") +
		Html.Write("TD","") + rs.Fields("EndDate") +
		Html.Write("TD","RIGHT") + rs.Fields("RecVol").value.toDelimited(0) +
		Html.Write("TD","RIGHT") + rs.Fields("RetVol").value.toDelimited(0) +
		Html.Write("TD","") + rs.Fields("BranchName") + '</TD></TR>\n';
		rs.MoveNext();
	} rs.Close();Connect.Close();
	ResponseText += Html.GetFooterRow(7, i);
	Response.Write(ResponseText);
}%>