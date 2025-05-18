<% //@ LANGUAGE = "JScript"
var XmlHttp = Server.CreateObject("MSXML2.ServerXmlHttp.6.0"),
FXRate = {
	GetExchangeRate: function(url) {
		with (XmlHttp) {
			open("GET", url, false);
			send();
		}
		var OkText = "Server response: " + XmlHttp.responseText,
		ErrText = "An error occurred: " + XmlHttp.status + " - " + XmlHttp.statusText,
		ResponseText = XmlHttp.status == 200 ? OkText : ErrText;
		//Response.Write(ResponseText);
	}
}%>