<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% if (Session("RoleId") != 0) Solaren.SysMsg(2, "Помилка авторизації");

var ServerInfo = {
	Text: '\n<BODY CLASS="MainBody">\n' +
	'<H3 CLASS="HeadText">&#128187;Сервер</H3>\n' +
	'<DIV CLASS="FormDiv">\n' +
	'<FIELDSET CLASS="FieldSet">\n' +
	'<LEGEND>Параметри</LEGEND><TABLE CLASS="RulesAllInfo">\n' +
	'<TR><TH>Ключ</TH><TH>Значення</TH></TR>\n',

	AddRow: function(Key, Value) {
		if (Value != "") {
			this.Text += '<TR><TD ALIGN="RIGHT">' + Key + Html.Write("TD","LEFT") + Value + '</TD></TR>\n';
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

with (Html) {
	SetHead("Сервер");
	WriteMenu(Session("RoleId"), 0);
}

with (ServerInfo) {
	AddSessionInfo(SessionInfo);
	AddInfo();
	Text += '</TABLE></FIELDSET></DIV></BODY></HTML>';
}

Response.Write(ServerInfo.Text)%>