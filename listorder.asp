<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->

<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
	var BegDate = String(Form("BegDate")),
	EndDate     = String(Form("EndDate")),
	ContractId  = Form("ContractId"),
	Deleted     = Form("Deleted") == "on";
}

try {
	Solaren.SetCmd("ListOrder");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("BegDate", adVarChar, adParamInput, 10, BegDate));
			Append(CreateParameter("EndDate", adVarChar, adParamInput, 10, EndDate));
			Append(CreateParameter("ContractId", adVarChar, adParamInput, 10, ContractId));
			Append(CreateParameter("Deleted", adBoolean, adParamInput, 1, Deleted));
		}
	}
	var rs = Cmd.Execute();
	Solaren.EOF(rs, 'Iнформацiю не знайдено');
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

var Period = BegDate.formatDate("-"),
EndDate    = EndDate.formatDate("-");

if (Period != EndDate) Period += ' &ndash; ' + EndDate;

var ResponseText = '<BODY CLASS="MainBody" ONLOAD="Loader.SetClick(`td > a`)">\n' +
	'<H3 CLASS="H3Text">Список замовлень<SPAN>Період: ' + Period + '</SPAN></H3>\n' +
	'<TABLE CLASS="InfoTable">\n' + 
	'<TR><TH>№</TH><TH>Дaта</TH><TH>Споживач</TH><TH>Рахунок</TH></TR>\n';

with (Html) {
	SetHead("Список замовлень");
	WriteMenu(Session("RoleId"), 0);
}

for (var i=0; !rs.EOF; i++) {
	ResponseText += '<TR><TD>' + '<A href="editorder.asp?OrderId=' + rs.Fields("OrderId") + '">' + rs.Fields("OrderId") + '</A>' +
	Html.Write("TD","LEFT") + rs.Fields("OrderDate") +
	Html.Write("TD","LEFT") + rs.Fields("CustomerName") +
	Html.Write("TD","") + rs.Fields("ContractPAN") + '</TD></TR>\n';
	rs.MoveNext();
} rs.Close();Connect.Close();
ResponseText += '<TR><TH ALIGN="LEFT" COLSPAN="3">Всього: ' + i + 
Html.Write("TH","RIGHT") + '</TH></TR>\n</TABLE></BODY></HTML>';
Response.Write(ResponseText)%>