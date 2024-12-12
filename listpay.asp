<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/money.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1;
User.ValidateAccess(Authorized, "POST");

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
    var BegDate      = String(Form("BegDate")),
	EndDate      = String(Form("EndDate")),
	ContractId   = Form("ContractId"),
	ContractName = Form("ContractName");
}

try {
	Solaren.SetCmd("ListPay");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("BegDate", adVarChar, adParamInput, 10, BegDate));
			Append(CreateParameter("EndDate", adVarChar, adParamInput, 10, EndDate));
			Append(CreateParameter("ContractId", adVarChar, adParamInput, 10, ContractId));
		}
	}
	var rs = Solaren.Execute("ListPay", "Iнформацiю не знайдено");
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

Html.SetPage("Список оплат", User.RoleId)

var Period = BegDate.formatDate("-"),
EndDate    = EndDate.formatDate("-"),
totalPay   = 0;
if (Period != EndDate) Period += ' &ndash; ' + EndDate;

var ResponseText = '<BODY CLASS="MainBody">\n' +
	'<TABLE CLASS="H3Text">\n' +
	'<CAPTION>' + Html.Title + '</CAPTION>\n' +
	'<TR><TD ALIGN="RIGHT">Споживач:</TD><TD ALIGN="LEFT">' + ContractName + '</TD></TR>\n' + 
	'<TR><TD ALIGN="RIGHT">Період:</TD><TD ALIGN="LEFT">' + Period + '</TD></TR>\n' +
	'</TABLE>\n' + 
	'<TABLE CLASS="InfoTable">\n' + 
	'<TR><TH>Дaта</TH><TH>Сума</TH></TR>\n';

for (var i=0; !rs.EOF; i++) {
	ResponseText += '<TR><TD>' + rs.Fields("CharPayDate") +
	Html.Write("TD","RIGHT") + '<A href="editpay.asp?PayId=' + rs.Fields("PayId") + '">' + rs.Fields("PaySum").value.toDelimited(2) + '</A></TD></TR>\n';
	totalPay += rs.Fields("PaySum").value;
	rs.MoveNext();
} rs.Close();Connect.Close();
ResponseText += '<TR><TH ALIGN="LEFT">Всього: ' + i + 
Html.Write("TH","RIGHT") + totalPay.toDelimited(2) + '</TH></TR>\n</TABLE></BODY></HTML>';
Response.Write(ResponseText)%>