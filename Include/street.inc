<% //@ LANGUAGE = "JScript"
var Street = {
	Type: ["вулиця", "проспект", "бульвар", "провулок", "площа", "тупік", "шоссе", "проїзд"],

	WriteType: function(tagName, index) {
		var ResponseText = ['<SELECT NAME="' + tagName + '">'],
		selected,
		row;
		for (var i = 0; i < this.Type.length; i++) {
			selected = i == index ? '" SELECTED>' : '">';
			row = ['<OPTION VALUE="', i, selected, this.Type[i], '</OPTION>'];
			ResponseText.push(row.join(""));
		}
		ResponseText.push('</SELECT>');
		Response.Write(ResponseText.join("\n"));
	}
}%>