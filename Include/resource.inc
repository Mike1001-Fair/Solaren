<% //@ LANGUAGE = "JScript"
var Fso = Server.CreateObject("Scripting.FileSystemObject"),
XmlDoc = Server.CreateObject("MSXML2.DOMDocument.6.0"),
Dictionary = Server.CreateObject("Scripting.Dictionary"),
Resource = {
	ErrText: "",

	Map: function(fileName) {
		var Path = "Resources/";
 		return Server.MapPath(Path + fileName)
 	},

	Error: function() {
		Session("SysMsg") = this.ErrText;
		Session("ScriptName") = "resources.inc";
		//Server.Transfer("error-en.asp");	
	},

	Load: function(fileName) {
		var FileName = this.Map(fileName);
		if (Fso.FileExists(FileName)) {
			try {
				if (XmlDoc.load(FileName)) {
					var itemNodes = new Enumerator(XmlDoc.selectNodes("//Item"));
					for (var node, itemID; !itemNodes.atEnd(); itemNodes.moveNext()) {
						node = itemNodes.item();
						itemID = node.getAttribute("id");
						if (!Dictionary.Exists(itemID)) {
							Dictionary.Add(itemID, node.text);
						}
					}
				} else {
					var error = XmlDoc.parseError,
					errText = ["Error: " + error.reason, "Line: " + error.line, "File: " + FileName];
					Resource.ErrText = errText.join("<BR>");
					Resource.Error();
				}
			} catch (ex) {
				Resource.ErrText = ex.name + ": " + ex.message;
				Resource.Error();
			}
		} else {
			Resource.ErrText = FileName + " not found";
			Resource.Error();
		}
	},

	GetText: function(id) {
		return Dictionary.Exists(id) ? Dictionary.Item(id) : "";
	}
}%>