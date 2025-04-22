<% //@ LANGUAGE = "JScript"
var Street = {
	Type: ["вулиця", "проспект", "бульвар", "провулок", "площа", "тупік", "шоссе", "проїзд"],

	WriteType: function(tagName, index) {
		var ResponseText = ['<SELECT NAME="' + tagName + '">'];
		for (var i = 0; i < this.Type.length; i++) {
			var selected = i == index ? '" SELECTED>' : '">',
			option = ['<OPTION VALUE="', i, selected, this.Type[i], '</OPTION>'];
			ResponseText.push(option.join(""));
		}
		ResponseText.push('</SELECT>');
		Response.Write(ResponseText.join("\n"));
	}
}%>