<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->

<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

try {
	Solaren.SetCmd("ListNoTarif");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
		}
	}
	var rs = Cmd.Execute();
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

if (rs.EOF) {
	Solaren.SysMsg(1, "Помилок не виявлено");
} else {
	with (Html) {
		SetHead("Обсяги");
		Menu.Write(Session("RoleId"), 0);
	}
	Response.Write('<BODY CLASS="MainBody">\n' +
	'<H3 CLASS="H3Text">Перевiрка тарифу</H3>\n' +
	'<TABLE CLASS="InfoTable">\n' +
	'<TR><TH>Споживач</TH><TH>Рахунок</TH><TH>З</TH><TH>По</TH></TH><TH>Обсяг<BR>кВт&#183;год</TH><TH>Вартiсть<BR>грн</TH><TH>ЦОС</TH></TR>\n');
	for (var i=0; !rs.EOF; i++) {
		Response.Write('<TR><TD>' + rs.Fields("CustomerName") + 
		Html.Write("TD","") + rs.Fields("ContractPAN") +
		Html.Write("TD","") + rs.Fields("BegDate") +
		Html.Write("TD","") + rs.Fields("EndDate") +
		Html.Write("TD","RIGHT") + rs.Fields("PurVol").value.toDelimited(0) +
		Html.Write("TD","RIGHT") + rs.Fields("VolCost").value.toDelimited(2) +
		Html.Write("TD","") + rs.Fields("BranchName") + '</TD></TR>\n');
		rs.MoveNext();
	} rs.Close();Connect.Close();
	Response.Write('<TR><TH ALIGN="LEFT" COLSPAN="7">Всього: ' + i + '</TH></TR>\n</TABLE></BODY></HTML>');
}%>