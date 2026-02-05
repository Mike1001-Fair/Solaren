<% //@ LANGUAGE = "JScript
var Webserver = {
	Name: String(Request.ServerVariables("SERVER_NAME")) || "",
	Script: String(Request.ServerVariables("SCRIPT_NAME")) || "",
	Referer: String(Request.ServerVariables("HTTP_REFERER")) || "",
	Method : String(Request.ServerVariables("REQUEST_METHOD")) || "",

	Empty: function(testvar) {
		return testvar == undefined || testvar == null || testvar == "";
	},

	ValidObject: function(obj) {
		return obj && typeof obj === 'object'
	},

	Debug: function(obj) {
		if (this.ValidObject(obj)) {
			var Output = ['<H3 CLASS="HeadText">🐛Дебаг</H3>',
				'<DIV CLASS="FormDiv">',
				'<FIELDSET CLASS="FieldSet">',
				'<LEGEND>Параметри</LEGEND>',
				'<TABLE CLASS="RulesAllInfo">',
				'<TR><TH>Ключ</TH><TH>Значення</TH></TR>'
			];
			for (var key in obj) {
				var td = [Tag.Write("TD", 1, key),
					Tag.Write("TD", 1, obj[key])
				],
				tr = Tag.Write("TR", -1, td.join(""));
				Output.push(tr);	
			}
			Output.push("</TABLE></FIELDSET></DIV>");
			this.Write(Output.join("\n"))
		} else {
			Message.Write(3, 'Debug: Invalid input object');
		}
	},

	Write: function(Output) {
		with (Response) {
			Charset = "utf-8";
			ContentType = "text/html";
			Write(Output);
		}
	},

	Map: function(Collection) {
		var result = {};
		if (this.ValidObject(Collection)) {			
			for (var items = new Enumerator(Collection); !items.atEnd(); items.moveNext()) {
				var item = items.item(),
				hasName = item && typeof item.Name === "string",
				key = hasName ? item.Name : item,
				value = hasName ? item.Value : Collection(item);
				result[key] = value;
			}
		} else {
			Message.Write(3, 'Map: Invalid input object');
		}
		return result
	},

	Filter: function(key) {
		var Host = {
			"localhost": 1,
			"192.168.31.77": 1
		};
		return Host[this.Name] && this.Referer && this.Referer.indexOf(key) > -1 
	},

	Collection: function() {
		var Source = {
			"GET": Request.QueryString,
			"POST": Request.Form,
			"PUT": Request.Form,
			"DELETE": Request.QueryString,
			"DEFAULT": Request.QueryString
		};
		return Source[this.Method] || Source.DEFAULT;
	},

	Parse: function() {
		var collection = this.Collection(),
		filter = this.Filter(Application("AppName"));
		return filter ? this.Map(collection) : {};
	},

	GetRandInt: function(intMin, intMax) {
		var rand = intMin + Math.random() * (intMax + 1 - intMin);
		return Math.floor(rand);
	}
}%>