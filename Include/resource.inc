<% //@ LANGUAGE = "JScript"
var XmlDoc = Server.CreateObject("MSXML2.DOMDocument.6.0"),
Fso        = Server.CreateObject("Scripting.FileSystemObject"),
Dictionary = Server.CreateObject("Scripting.Dictionary"),
Resource = {
	Path: "Resources/",

	Map: function(fileName) {
 		return Server.MapPath(this.Path + fileName)
 	},

	ErrMsg: function(Msg) {
		Session("SysMsg") = Msg;
		Session("ScriptName") = "resources.inc";
		Server.Transfer("error-en.asp");	
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
					errText = ["Error: ", error.reason, "<BR>Line: ", error.line, "<BR>File: ", FileName];
					Resource.ErrMsg(errText.join(""));
				}
			} catch (ex) {
				Resource.ErrMsg(ex.name + ": " + ex.message + "<BR>File: " + FileName);
			}
		} else {
			Resource.ErrMsg("File: " + FileName + " not found");
		}
	}
}%>