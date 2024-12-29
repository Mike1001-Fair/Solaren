<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 0,
Title = "Сервер";
User.ValidateAccess(Authorized, "GET");

var ServerInfo = {
	Text: ['\n<BODY CLASS="MainBody">\n',
	'<H3 CLASS="HeadText">&#128187;' + Title + '</H3>\n',
	'<DIV CLASS="FormDiv">\n',
	'<FIELDSET CLASS="FieldSet">\n',
	'<LEGEND>Параметри</LEGEND><TABLE CLASS="RulesAllInfo">\n',
	'<TR><TH>Ключ</TH><TH>Значення</TH></TR>\n'],

	AddRow: function(Key, Value) {
		if (Value != "") {
			var td = Html.Write("TD","LEFT"),
			row = ['<TR><TD ALIGN="RIGHT">', Key, td, Value, '</TD></TR>\n'];
			this.Text.push(row.join(""));
		}
	},

	AddSessionInfo: function() {
		for (var k in SessionInfo) {
			this.AddRow(k, SessionInfo[k]);
		}
	},

	AddInfo: function() {
		var SrvVarName, SrvVarValue,
		SrvVar = new Enumerator(Request.ServerVariables);
		for (; !SrvVar.atEnd(); SrvVar.moveNext()) {
			SrvVarName = SrvVar.item();
			SrvVarValue = Request.ServerVariables(SrvVarName);
			this.AddRow(SrvVarName, SrvVarValue);
		}
	}
},

SessionInfo = {
	"SESSION_COUNT": Application("SesCount"),
	"SESSION_TIMEOUT": Session.Timeout,
	"SESSION_CODEPAGE": Session.CodePage
};

Html.SetHead(Title);
Menu.Write(User.RoleId, 0);

with (ServerInfo) {
	AddSessionInfo();
	AddInfo();
	Text.push('</TABLE></FIELDSET></DIV></BODY></HTML>');
}

Response.Write(ServerInfo.Text.join(""))%>