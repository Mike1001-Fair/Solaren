<% //@ LANGUAGE = "JScript"
var XmlHttp = Server.CreateObject("MSXML2.ServerXmlHttp.6.0"),
FXRate = {
	GetExchangeRate: function(url) {
		with (XmlHttp) {
			open("GET", url, false);
			send();
		}

		if (XmlHttp.status == 200) {
			Response.Write("Server response: " + XmlHttp.responseText);
		} else {
			Response.Write("An error occurred: " + XmlHttp.status + " - " + XmlHttp.statusText);
		}
	}
}%>
