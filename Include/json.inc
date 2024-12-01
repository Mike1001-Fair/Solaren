<% //@ LANGUAGE = "JScript"
var Json = {
	toString: function (obj) {
		var JsonString ='[';
		if (Solaren.ValidObject(obj)) {
			var Items = new Enumerator(obj);
			for (var itemSet = []; !Items.atEnd(); Items.moveNext()) {
				itemSet.push('"' + Items.item().Name + '"');
			}
			JsonString += itemSet.join(",");
		} else {
			JsonString += '-1';
		}
		JsonString += ']'; 
		return JsonString;
	}
}%>