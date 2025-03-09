<% //@ LANGUAGE = "JScript"
var Locality = {
	Type: ["місто", "селище", "село", "смт"],

	WriteType: function(tagName, LocalityType) {
		var ResponseText = ['<SELECT NAME="' + tagName + '" ID="' + tagName + '">'],
		itemNodes = new Enumerator(XmlDoc.selectNodes("//LocalityType")),
		itemId,
		selected;
		for (var node; !itemNodes.atEnd(); itemNodes.moveNext()) {
			node = itemNodes.item();
			itemId = node.getAttribute("id");
			selected = itemId == LocalityType ? '" SELECTED>' : '">';
			ResponseText.push('<OPTION VALUE="' + itemId + selected + node.text + '</OPTION>');
		}
		ResponseText.push('</SELECT>');
		Response.Write(ResponseText.join("\n"));
	}
}%>
