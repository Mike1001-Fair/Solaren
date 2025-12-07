<% //@ LANGUAGE = "JScript"
var Locality = {
	Type: ["місто", "селище", "село", "смт"],

	WriteType: function(tagName, index) {
		var Output = ['<SELECT NAME="' + tagName + '" ID="' + tagName + '">'],
		itemNodes = new Enumerator(XmlDoc.selectNodes("//LocalityType"));
		for (; !itemNodes.atEnd(); itemNodes.moveNext()) {
			var node = itemNodes.item(),
			itemId = node.getAttribute("id"),
			selected = itemId == index,
			option = Html.GetOption(itemId, selected, node.text);
			Output.push(option);
		}
		Output.push('</SELECT>');
		Response.Write(Output.join("\n"));
	}
}%>
