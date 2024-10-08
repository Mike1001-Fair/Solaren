﻿<% //@ LANGUAGE = "JScript"
var XmlDoc = Server.CreateObject("MSXML2.DOMDocument.6.0"),
Fso        = Server.CreateObject("Scripting.FileSystemObject"),
Dictionary = Server.CreateObject("Scripting.Dictionary"),
Resource = {
	Path: "Resources/",

	ErrMsg: function(Msg) {
		Session("SysMsg") = Msg;
		Session("ScriptName") = "resources.inc";
		Server.Transfer("error-en.asp");	
	},

	Load: function(FileName) {
		FileName = Server.MapPath(this.Path + FileName);
		if (Fso.FileExists(FileName)) {
			try {
				XmlDoc.onreadystatechange = function() {
					if (XmlDoc.readyState == 4) {
						if (XmlDoc.parseError.errorCode == 0) {
							var itemNodes = new Enumerator(XmlDoc.selectNodes("//Item"));
							for (var node, itemID; !itemNodes.atEnd(); itemNodes.moveNext()) {
								node = itemNodes.item();
								itemID = node.getAttribute("id");
								if (!Dictionary.Exists(itemID)) {
									Dictionary.Add(itemID, node.text);
								}
							}
						} else {
							var error = XmlDoc.parseError;
							Resource.ErrMsg("Error: " + error.reason + "<BR>Line: " + error.line + "<BR>File: " + FileName);
						}
					}
				};
				XmlDoc.load(FileName);
			} catch (ex) {
				Resource.ErrMsg(ex.name + ": " + ex.message + "<BR>File: " + FileName);
			}
		} else {
			Resource.ErrMsg("File: " + FileName + " not found");
		}
	}
}%>