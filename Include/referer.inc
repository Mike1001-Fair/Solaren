<% //@ LANGUAGE = "JScript"
var Referer = {
	Value: String(Request.ServerVariables("HTTP_REFERER")),

	Match: function(key) {
		return this.Value.indexOf(key) > -1;
	}
}%>