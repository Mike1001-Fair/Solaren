<% //@ LANGUAGE = "JScript"
var Message = { 
	Page: ["errmsg", "done", "accessdenied", "error"],

	Error: function(ex) {
		var ErrMsg = [];
		if (Solaren.ValidObject(ex)) {
			if (Connect.Errors.Count) {
				for (var i = 0; i < Connect.Errors.Count; i++) {
					var row = [Connect.Errors(i).number, Connect.Errors(i).description];
					ErrMsg.push(row.join(": "));
				}
			} else {
				ErrMsg.push(ex.name + ": " + ex.message);
			}
		} else {
			ErrMsg.push("Unknown exception");
		}
		return ErrMsg.join("\n")
	},

	Write: function(msgType, msgText) {
		if (!this.Page[msgType]) {
			msgType = this.Page.length - 1 // if out of range - default error page
			msgText = "Runtime Error: out of range";			
		}
		//Session("SysMsg") = msgText;
		Session("SysMsg") = msgText;
		Session("ScriptName") = Solaren.ScriptName;
		Response.Redirect(this.Page[msgType] + ".asp");
	}
}%>