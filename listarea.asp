<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2,
AreaName = Request.Form("AreaName"),
Title = "Райони";

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

try {
	Solaren.SetCmd("ListArea");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("AreaName", adVarChar, adParamInput, 10, AreaName));
		}
	}
	var rs = Cmd.Execute();
	Solaren.EOF(rs, 'Iнформацiю не знайдено');
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

with (Html) {
	SetHead(Title);
	WriteMenu(Session("RoleId"), 0);
}

var ResponseText = '<BODY CLASS="MainBody" ONLOAD="Loader.SetClick(`td > a`)">\n' +
	'<H3 CLASS="H3Text">' + Title + '</H3>\n' +
	'<TABLE CLASS="InfoTable">\n' +
	'<TR><TH>№</TH><TH>Назва</TH></TR>\n';

for (var i=0; !rs.EOF; i++) {
	ResponseText += '<TR><TD ALIGN="CENTER">' + rs.Fields("SortCode") +
	Html.Write("TD","LEFT") + '<A HREF="editarea.asp?AreaId=' + rs.Fields("Id") + '">' + rs.Fields("AreaName") + '</A></TD></TR>\n';
	rs.MoveNext();
} rs.Close();Connect.Close();
ResponseText += Html.GetFooterRow(2, i);
Response.Write(ResponseText)%>