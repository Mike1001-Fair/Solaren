<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2,
TitleName = Request.Form("TitleName");

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");
try {
	Solaren.SetCmd("ListChiefTitle");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("TitleName", adVarChar, adParamInput, 10, TitleName));
		}
	}
	var rs = Cmd.Execute();
	Solaren.EOF(rs, 'Iнформацiю не знайдено');
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

with (Html) {
	SetHead("Посади керівників");
	WriteMenu(Session("RoleId"), 0);
}

var ResponseText = '<BODY CLASS="MainBody">\n' +
	'<H3 CLASS="H3Text">Посади<SPAN>керівників</SPAN></H3>\n' +
	'<TABLE CLASS="InfoTable">\n' + 
	'<TR><TH>Посада</TH></TR>\n';

for (var i=0; !rs.EOF; i++) {
	ResponseText += '<TR><TD ALIGN="LEFT"><A href="editchieftitle.asp?ChiefTitleId=' + rs.Fields("Id") + '">' + rs.Fields("Title1") + '</A></TD></TR>\n';
	rs.MoveNext();
} rs.Close();Connect.Close();
ResponseText += Html.GetFooterRow(1, i);
Response.Write(ResponseText)%>