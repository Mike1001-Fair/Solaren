<% //@ LANGUAGE = "JScript"
var Locality = {
	Type: ["місто", "селище", "село", "смт"],

	/*WriteLocalityType: function(tagName, LocalityType) {
		var ResponseText = '<SELECT NAME="' + tagName + '" ID="' + tagName + '">',
		selected, option;
		for (var k in this.LocalityType) {
			selected = k == LocalityType ? '" SELECTED>' : '">';
			option = ['<OPTION VALUE="', k, selected, this.LocalityType[k], '</OPTION>'];
			ResponseText += option.join("");
		}
		Response.Write(ResponseText + '</SELECT>')
	},*/

	WriteType: function(tagName, LocalityType) {
		var ResponseText = ['<SELECT NAME="', tagName, '" ID="', tagName, '">'],
		itemNodes = new Enumerator(XmlDoc.selectNodes("//LocalityType")),
		itemId,
		option,
		selected;
		for (var node; !itemNodes.atEnd(); itemNodes.moveNext()) {
			node = itemNodes.item();
			itemId = node.getAttribute("id");
			selected = itemId == LocalityType ? '" SELECTED>' : '">';
			option = ['<OPTION VALUE="', itemId, selected, node.text, '</OPTION>'];
			ResponseText.push(option.join(""));
		}
		ResponseText.push('</SELECT>');
		Response.Write(ResponseText.join(""));
	}
}%>
