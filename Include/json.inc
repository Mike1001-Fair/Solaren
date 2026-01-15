<% //@ LANGUAGE = "JScript"
var Json = {
	data: "",

	toString: function (obj) {
		var result = ['['];		
		if (Webserver.ValidObject(obj)) {
			var Items = new Enumerator(obj);
			for (var itemSet = []; !Items.atEnd(); Items.moveNext()) {
				var itemName = ['"', Items.item().Name, '"'];
				itemSet.push(itemName.join(""));
			}
			result.push(itemSet.join(","));
		} else {
			result.push('-1');
		}
		result.push(']');
		return result.join("");
	},

	write: function() {
		with (Response) {
			CacheControl = "no-cache, no-store, must-revalidate";
			AddHeader("Content-Type", "application/json");
			Write(this.data);
		}
	},

	error: function(ex, errCode) {
		this.data = errCode;
		Session("ScriptName") = Solaren.ScriptName;
		Session("SysMsg") = Message.Error(ex);
	},

	parse: function (text) {
 		return eval("(" + text + ")");
	},

	esc: function (str) {
		return str.replace(/\\/g, "\\\\")
			.replace(/"/g, "\\\"")
			.replace(/\n/g, "\\n")
			.replace(/\r/g, "\\r")
			.replace(/\t/g, "\\t")
			.replace(/\b/g, "\\b")
			.replace(/\f/g, "\\f");
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
}%>