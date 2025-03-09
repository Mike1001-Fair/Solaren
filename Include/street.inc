<% //@ LANGUAGE = "JScript"
var Street = {
	Type: ["вулиця", "проспект", "бульвар", "провулок", "площа", "тупік", "шоссе", "проїзд"],

	WriteType: function(tagName, StreetType) {
		var ResponseText = ['<SELECT NAME="' + tagName + '">'],
		selected;
		for (var i = 0; i < this.Type.length; i++) {
			selected = i == StreetType ? '" SELECTED>' : '">';
			ResponseText.push('<OPTION VALUE="' + i + selected + this.Type[i] + '</OPTION>');
		}
		ResponseText.push('</SELECT>');
		Response.Write(ResponseText.join("\n"))
	}
}%>