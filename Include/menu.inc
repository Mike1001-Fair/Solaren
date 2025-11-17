<% //@ LANGUAGE = "JScript"
var Menu = {
	Type: ["admin", "officeuser", "branchuser"],

	Map: function(RoleId) {
		return ["menu-", this.Type[RoleId] || "empty", ".asp"].join("");
	},

	Write: function(BodyTag) {
		var page = this.Map(Session("RoleId")),
		msg = Session('MsgText');
		if (BodyTag) {
			var Output = ['\n<BODY CLASS="MainBody" ID="MainBody">'];
			if (msg) {
				Output.push('<INPUT TYPE="HIDDEN" NAME="MsgText" ID="MsgText" VALUE="' + msg + '">');
			}
			Response.Write(Output.join("\n"));
			Server.Execute(page);
			Response.Write('</BODY></HTML>');
		} else {
			Server.Execute(page);
		}
	}
}%>