<% //@ LANGUAGE = "JScript"
var Json = {
	toString: function (obj) {
		var JsonString = ['['];		
		if (Solaren.ValidObject(obj)) {
			var Items = new Enumerator(obj);
			for (var itemSet = []; !Items.atEnd(); Items.moveNext()) {
				var itemName = ['"', Items.item().Name, '"'];
				itemSet.push(itemName.join(""));
			}
			JsonString.push(itemSet.join(","));
		} else {
			JsonString.push('-1');
		}
		JsonString.push(']');
		return JsonString.join("");
	},

	parse: function (text) {
 		return eval("(" + text + ")");
	},

	esc: function (str) {
		return str.replace(/\\/g, "\\\\")
			.replace(/"/g, "\\\"")
			.replace(/\n/g, "\\n")
			.replace(/\r/g, "\\r")
			.replace(/\t/g, "\\t");
	},

	stringify: function (obj) {
		var str = function (value) {
			var type = typeof value;
			if (value === null) return "null";
			if (type === "number") {
				return isFinite(value) ? String(value) : "null";
			}
			if (type === "boolean") return String(value);
			if (type === "string") return "\"" + Json.esc(value) + "\"";
			if (type === "object") {
				if (value instanceof Array) {
					var arr = [];
					for (var i = 0; i < value.length; i++) {
						arr.push(str(value[i]));
					}
					return "[" + arr.join(",") + "]";
				} else {
					var obj = [];
					for (var key in value) {
						if (Object.prototype.hasOwnProperty.call(value, key)) {
							var val = str(value[key]);
							if (val !== "undefined") {
								obj.push("\"" + Json.esc(key) + "\":" + val);
							}
						}
					}
					return "{" + obj.join(",") + "}";
				}
			}
  			return "null";
		};
 		return str(obj);
	}
};
%>