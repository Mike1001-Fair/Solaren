<% //@ LANGUAGE = "JScript"
var Locality = {
	Type: ["місто", "селище", "село", "смт"],

	WriteType: function(tagName, index) {
		var ResponseText = ['<SELECT NAME="' + tagName + '" ID="' + tagName + '">'],
		itemNodes = new Enumerator(XmlDoc.selectNodes("//LocalityType")),
		itemId,
		selected,
		row;
		for (var node; !itemNodes.atEnd(); itemNodes.moveNext()) {
			node = itemNodes.item();
			itemId = node.getAttribute("id");
			selected = itemId == index ? '" SELECTED>' : '">';
			row = ['<OPTION VALUE="', itemId, selected, node.text, '</OPTION>'];
			ResponseText.push(row.join(""));
		}
		ResponseText.push('</SELECT>');
		Response.Write(ResponseText.join("\n"));
	}
}%>
