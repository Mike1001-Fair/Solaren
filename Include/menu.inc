<% //@ LANGUAGE = "JScript"
var Menu = {
	Path: './',
	Map: function(RoleId) {
		var Type = ["admin", "officeuser", "branchuser"],
		page = ["menu-" + (Type[RoleId] || "empty"), "asp"],
		url = [this.Path, page.join(".")];
		return url.join("");
	},

	Write: function(BodyTag) {
		var page = this.Map(Session("RoleId")),
		msg = Session('MsgText');

		//Response.Write(page);
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