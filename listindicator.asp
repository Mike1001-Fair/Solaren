<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId > 0 && User.RoleId < 3,
Title = "Показники лiчильника";
User.ValidateAccess(Authorized, "POST");

with (Request) {
    var ContractId   = Form("ContractId"),
	BegDate      = Form("BegDate"),
	EndDate      = Form("EndDate"),
	ContractName = Form("ContractName");
}

try {
	Solaren.SetCmd("ListIndicator");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("ContractId", adVarChar, adParamInput, 10, ContractId));
			Append(CreateParameter("BegDate", adVarChar, adParamInput, 10, BegDate));
			Append(CreateParameter("EndDate", adVarChar, adParamInput, 10, EndDate));
		}
	}
	var rs = Solaren.Execute("ListIndicator", "Iнформацiю не знайдено");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}

Html.SetPage(Title, User.RoleId);

var ResponseText = '<BODY CLASS="MainBody">\n' +
	'<TABLE CLASS="H3Text">\n' +
	'<CAPTION>' + Title + '</CAPTION>\n' +
	'<TR><TD ALIGN="RIGHT">Споживач:</TD><TD ALIGN="LEFT">' + ContractName + '</TD></TR>\n' + 
	'</TABLE>\n' + 
	'<TABLE CLASS="InfoTable">\n' + 
	'<TR><TH>Номер</TH><TH>Дата</TH><TH>Прийом</TH><TH>Видача</TH></TR>\n';
for (var i=0; !rs.EOF; i++) {
	ResponseText += '<TR><TD ALIGN="RIGHT">' + rs.Fields("MeterCode") +
	Html.Write("TD","RIGHT") + '<A href="editindicator.asp?IndicatorId=' + rs.Fields("Id") + '">' + rs.Fields("ReportDate") + '</A>' +
	Html.Write("TD","RIGHT") + rs.Fields("RecVal").value.toDelimited(0) +
	Html.Write("TD","RIGHT") + rs.Fields("RetVal").value.toDelimited(0) + '</TD></TR>\n';
	rs.MoveNext();
} rs.Close(); Connect.Close();
ResponseText += '<TR><TH ALIGN="LEFT" COLSPAN="4">Всього: ' + i + '</TH></TR>\n</TABLE></BODY></HTML>';
Response.Write(ResponseText)%>
