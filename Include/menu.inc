<% //@ LANGUAGE = "JScript"
var Menu = {
	Map: function(RoleId) {
		var Type = ["admin", "officeuser", "branchuser"],
		fullName = ["menu-", Type[RoleId] || "empty", ".asp"];
		return fullName.join("");
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