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
			var ResponseText = ['\n<BODY CLASS="MainBody" ID="MainBody">'];
			if (msg) {
				ResponseText.push('<INPUT TYPE="HIDDEN" NAME="MsgText" ID="MsgText" VALUE="' + msg + '">');
			}
			Response.Write(ResponseText.join("\n"));
			Server.Execute(page);
			Response.Write('</BODY></HTML>');
		} else {
			Server.Execute(page);
		}
		//Response.Write("<br>User.LoginId=" + User.LoginId);
	}
}%>