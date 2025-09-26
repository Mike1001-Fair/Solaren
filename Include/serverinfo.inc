<% //@ LANGUAGE = "JScript"
var ServerInfo = {
	Body: ['\n<BODY CLASS="MainBody">',
		'<H3 CLASS="HeadText">&#128187;Сервер</H3>',
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
			this.Body.push(tr);
		}
	},

	AddObjInfo: function(obj) {
		for (var k in obj) {
			this.AddRow(k, obj[k]);
		}
	},	

	AddRequestInfo: function() {
		var srvEnum = new Enumerator(Request.ServerVariables);
		for (; !srvEnum.atEnd(); srvEnum.moveNext()) {
			var key = srvEnum.item(),
			value = Request.ServerVariables(key);
			this.AddRow(key, value);
		}
	}
}%>
