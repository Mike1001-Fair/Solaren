<% //@ LANGUAGE = "JScript"
var Tarif = {
	Group: ["Сонце до 30 кВт", "Сонце до 50 кВт", "Комбінована до 50 кВт"],

	Write: function(tagName, GroupId) {
		var Output = ['<SELECT NAME="' + tagName + '">'],
		selected, option;
		for (var i = 0; i < this.Group.length; i++) {
			selected = i == GroupId ? '" SELECTED>' : '">';
			option = ['<OPTION VALUE="', i, selected, this.Group[i], '</OPTION>'];
			Output.push(option.join(""));
		}
		Output.push('</SELECT>');
		Response.Write(Output.join("\n"))
	},

	WriteGroup: function() {
		var Output = ['<FIELDSET>', '<LEGEND>Група</LEGEND>', '<SELECT NAME="GroupId">'],
		option;
		for (var i = 0; i < this.Group.length; i++) {
			option = ['<OPTION VALUE="', i, '">', this.Group[i], '</OPTION>'];
			Output.push(option.join(""));
		}
		Output.push('</SELECT>\n</FIELDSET>\n');
		Response.Write(Output.join("\n"));
	}
}%>