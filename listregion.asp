<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
RegionName = Request.Form("RegionName");

User.ValidateAccess(Authorized, "POST");

try {
	Solaren.SetCmd("ListRegion");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("RegionName", adVarChar, adParamInput, 10, RegionName));
		}
	}
	var rs = Solaren.Execute("ListRegion");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}

Html.SetPage("Області", User.RoleId)

var ResponseText = '<BODY CLASS="MainBody">\n' +
	'<H3 CLASS="H3Text">' + Html.Title + '</H3>\n' +
	'<TABLE CLASS="InfoTable">\n' +
	'<TR><TH>№</TH><TH>Назва</TH></TR>\n';

for (var i=0; !rs.EOF; i++) {
	ResponseText += '<TR><TD ALIGN="CENTER">' + rs.Fields("SortCode") +
	Html.Write("TD","LEFT") + '<A HREF="editregion.asp?RegionId=' + rs.Fields("Id") + '">' + rs.Fields("RegionName") + '</A></TD></TR>\n';
	rs.MoveNext();
} rs.Close();Solaren.Close();
ResponseText += Html.GetFooterRow(2, i);
Response.Write(ResponseText)%>
