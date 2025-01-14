<% //@ LANGUAGE = "JScript"
var Tarif = {
	Group: ["Сонце до 30 кВт", "Сонце до 50 кВт", "Комбінована до 50 кВт"],

	Write: function(tagName, GroupId) {
		var ResponseText = ['<SELECT NAME="' + tagName + '">'],
		selected, option;
		for (var i = 0; i < this.Group.length; i++) {
			selected = i == GroupId ? '" SELECTED>' : '">';
			option = ['<OPTION VALUE="', i, selected, this.Group[i], '</OPTION>'];
			ResponseText.push(option.join(""));
		}
		ResponseText.push('</SELECT>');
		Response.Write(ResponseText.join("\n"))
	},

	WriteGroup: function() {
		var ResponseText = ['<FIELDSET>', '<LEGEND>Група</LEGEND>', '<SELECT NAME="GroupId">'],
		option;
		for (var i = 0; i < this.Group.length; i++) {
			option = ['<OPTION VALUE="', i, '">', this.Group[i], '</OPTION>'];
			ResponseText.push(option.join(""));
		}
		ResponseText.push('</SELECT>\n</FIELDSET>\n');
		Response.Write(ResponseText.join("\n"));
	}
}%>