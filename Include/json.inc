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
	}
}%>