<% //@ LANGUAGE = "JScript"
var Referer = {
	Value: String(Request.ServerVariables("HTTP_REFERER")),

	Match: function(keyword) {
		return this.Value.indexOf(keyword) > -1;
	}
}%>