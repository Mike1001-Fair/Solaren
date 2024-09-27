<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") < 2,
CompanyName = Request.Form("CompanyName");

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");
try {
	Solaren.SetCmd("ListCompany");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
			Append(CreateParameter("CompanyName", adVarChar, adParamInput, 10, CompanyName));
		}
	}
	var rs = Cmd.Execute();
	Solaren.EOF(rs, 'Iнформацiю не знайдено');
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

with (Html) {
	SetHead("Список компаній");
	WriteScript();
	WriteMenu(Session("RoleId"), 0)
}

var ResponseText = '<BODY CLASS="MainBody">\n' +
	'<H3 CLASS="H3Text">Список компаній</H3>\n' +
	'<TABLE CLASS="InfoTable">\n' +
	'<TR><TH>ЄДРПОУ</TH><TH>ІПН</TH><TH>Назва</TH><TH>Телефон</TH></TR>\n';

for (var i=0; !rs.EOF; i++) {
	ResponseText += '<TR><TD>' + rs.Fields("CompanyCode") +
	Html.Write("TD","") + rs.Fields("TaxCode") +
	Html.Write("TD","") + '<A href="editcompany.asp?CompanyId=' + rs.Fields("Id") + '">' + rs.Fields("CompanyName") + '</A></TD>' +
	Html.Write("TD","") + rs.Fields("Phone") + '</TD></TR>\n';
	rs.MoveNext();
} rs.Close();Connect.Close();
ResponseText += Html.GetFooterRow(4, i);
Response.Write(ResponseText)%>