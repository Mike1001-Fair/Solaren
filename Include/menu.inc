<% //@ LANGUAGE = "JScript"
var Menu = {
	Type: ["admin", "officeuser", "branchuser"],

	Map: function(RoleId) {
		return ["menu-", this.Type[RoleId] || "empty", ".asp"].join("");
	},

	Write: function(BodyTag) {
		var page = this.Map(Session("RoleId"));
		if (BodyTag) {
			var ResponseText = ['\n<BODY CLASS="MainBody" ID="MainBody">'];
			if (Session('MsgText')) {
				ResponseText.push('<INPUT TYPE="HIDDEN" NAME="MsgText" ID="MsgText" VALUE="' + Session('MsgText') + '">');
			}
			Response.Write(ResponseText.join("\n"));
			Server.Execute(page);
			Response.Write('</BODY></HTML>');
		} else {
			Server.Execute(page);
		}
	}
}%>