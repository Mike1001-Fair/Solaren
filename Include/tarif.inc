<% //@ LANGUAGE = "JScript"
var Tarif = {
	Group: ["Сонце до 30 кВт", "Сонце до 50 кВт", "Комбінована до 50 кВт"],

	Write: function(tagName, GroupId) {
		var Output = ['<SELECT NAME="' + tagName + '">'];
		for (var i = 0; i < this.Group.length; i++) {
			var selected = i == GroupId,
			option = Html.GetOption(i, selected, this.Group[i]);
			Output.push(option);
		}
		Output.push('</SELECT>');
		Response.Write(Output.join("\n"))
	},

	WriteGroup: function() {
		var Output = ['<FIELDSET>', '<LEGEND>Група</LEGEND>', '<SELECT NAME="GroupId">'],
		option;
		for (var i = 0; i < this.Group.length; i++) {
			var option = Html.GetOption(i, 0, this.Group[i]);
			Output.push(option);
		}
		Output.push('</SELECT>\n</FIELDSET>\n');
		Response.Write(Output.join("\n"));
	}
}%>