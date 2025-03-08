<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
TitleName = Request.Form("TitleName");
User.ValidateAccess(Authorized, "POST");

try {
	Solaren.SetCmd("ListChiefTitle");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("TitleName", adVarChar, adParamInput, 10, TitleName));
		}
	}
	var rs = Solaren.Execute("ListChiefTitle", "Iнформацiю не знайдено");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}

Html.SetPage("Посади", User.RoleId)

var ResponseText = '<BODY CLASS="MainBody">\n' +
	'<H3 CLASS="H3Text">' + Html.Title + '</H3>\n' +
	'<TABLE CLASS="InfoTable">\n' + 
	'<TR><TH>Посада</TH></TR>\n';

for (var i=0; !rs.EOF; i++) {
	ResponseText += '<TR><TD ALIGN="LEFT"><A href="editchieftitle.asp?ChiefTitleId=' + rs.Fields("Id") + '">' + rs.Fields("Title1") + '</A></TD></TR>\n';
	rs.MoveNext();
} rs.Close();Solaren.Close();
ResponseText += Html.GetFooterRow(1, i);
Response.Write(ResponseText)%>
