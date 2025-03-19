<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2;
DocName = Request.Form("DocName");
User.ValidateAccess(Authorized, "POST");

try {
	Solaren.SetCmd("ListChiefDoc");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("DocName", adVarChar, adParamInput, 10, DocName));
		}
	}
	var rs = Solaren.Execute("ListChiefDoc");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}

Html.SetPage("Документи керівника", User.RoleId)

var ResponseText = '<BODY CLASS="MainBody">\n' +
	'<H3 CLASS="H3Text">' + Html.Title + '</H3>\n' +
	'<TABLE CLASS="InfoTable">\n' +
	'<TR><TH>№</TH><TH>Назва</TH></TR>\n';

for (var i=0; !rs.EOF; i++) {
	ResponseText += '<TR><TD ALIGN="CENTER">' + rs.Fields("SortCode") +
	Html.Write("TD","LEFT") + '<A HREF="editchiefdoc.asp?DocId=' + rs.Fields("Id") + '">' + rs.Fields("DocName") + '</A></TD></TR>\n';
	rs.MoveNext();
} rs.Close();Solaren.Close();
ResponseText += Html.GetFooterRow(2, i);
Response.Write(ResponseText)%>
