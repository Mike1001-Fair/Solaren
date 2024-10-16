<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/money.inc" -->

<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
	var ContractId = Form("ContractId"),
	BegMonth       = String(Form("BegMonth")),
	EndMonth       = String(Form("EndMonth")),
	ContractName   = Form("ContractName"),
	Deleted        = Form("Deleted") == "on";
}

try {
	Solaren.SetCmd("ListOper");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("ContractId", adVarChar, adParamInput, 10, ContractId));
			Append(CreateParameter("BegMonth", adVarChar, adParamInput, 10, BegMonth));
			Append(CreateParameter("EndMonth", adVarChar, adParamInput, 10, EndMonth));
			Append(CreateParameter("Deleted", adBoolean, adParamInput, 1, Deleted));
		}
	}
	var rs = Solaren.Execute("ListOper", "Iнформацiю не знайдено");
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

with (Html) {
	SetHead("Операції");
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}

var totRetVol = totVolCost = 0,
ResponseText = '<BODY CLASS="MainBody">\n' +
'<H3 CLASS="H3Text">Операції<SPAN>Договор: ' + ContractName + '</SPAN></H3>\n' +
'<TABLE CLASS="InfoTable">\n' +
'<TR><TH>З</TH><TH>По</TH><TH>Видача</TH><TH>Вартість</TH></TR>\n';

for (var i=0; !rs.EOF; i++) {
	ResponseText += '<TR><TD ALIGN="RIGHT"><A href="editoper.asp?FactVolId=' + rs.Fields("Id") + '">' + rs.Fields("BegDate") + '</A></TD>' +
	Html.Write("TD","") + rs.Fields("EndDate") +
	Html.Write("TD","RIGHT") + rs.Fields("RetVol").value.toDelimited(0) +
	Html.Write("TD","RIGHT") + rs.Fields("VolCost").value.toDelimited(2) + '</TD></TR>\n';
	totRetVol += rs.Fields("RetVol");
	totVolCost  += rs.Fields("VolCost");
	rs.MoveNext()
} rs.Close();
Connect.Close();
ResponseText += '<TR><TH ALIGN="LEFT" COLSPAN="2">Всього: ' + i +
Html.Write("TH","RIGHT") + totRetVol.toDelimited(0) +
Html.Write("TH","RIGHT") + totVolCost.toDelimited(2) + '</TH></TR>\n</TABLE></BODY></HTML>';
Response.Write(ResponseText)%>