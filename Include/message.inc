<% //@ LANGUAGE = "JScript"
var Message = { 
	Page: ["errmsg", "done", "accessdenied", "error"],

	Map: function(index) {
		return [this.Page[index] || "error", "asp"].join(".");
	},

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

	Write: function(index, msgText) {
		var page = this.Map(index);
		Session("SysMsg") = this.Page[index] ? msgText : "Message.Write: index is out of range -" + index;
		Session("ScriptName") = Solaren.ScriptName;
		Response.Redirect(page);
	}
}%>