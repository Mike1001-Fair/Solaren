<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/session.inc" -->
<% var Authorized = User.RoleId == 0,
Title = "Сервер";
User.ValidateAccess(Authorized, "GET");

var ServerInfo = {
	Text: ['\n<BODY CLASS="MainBody">',
		'<H3 CLASS="HeadText">&#128187;' + Title + '</H3>',
		'<DIV CLASS="FormDiv">',
		'<FIELDSET CLASS="FieldSet">',
		'<LEGEND>Параметри</LEGEND>',
		'<TABLE CLASS="RulesAllInfo">',
		'<TR><TH>Ключ</TH><TH>Значення</TH></TR>'
	],

	AddRow: function(Key, Value) {
		if (Value != "") {
			var td = [Tag.Write("TD", 2, Key), Tag.Write("TD", 0, Value)],
			tr = Tag.Write("TR", -1, td.join(""));
			this.Text.push(tr);
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
};

Html.SetHead(Title, 1);
Menu.Write(0);
ServerInfo.AddSessionInfo();
ServerInfo.AddInfo();
ServerInfo.Text.push('</TABLE></FIELDSET></DIV></BODY></HTML>');
Response.Write(ServerInfo.Text.join("\n"))%>