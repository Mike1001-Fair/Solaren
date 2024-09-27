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
};


/*var XmlHttp = Server.CreateObject("MSXML2.ServerXMLHTTP.6.0");
var FXRate = {
    GetExchangeRate: function(url) {
        XmlHttp.open("GET", url, true); // Асинхронный запрос
        var self = this; // Сохранение контекста
        XmlHttp.onreadystatechange = function() {
            FXRate.HandleStateChange();
        };
        XmlHttp.send();
        
        // Продолжение выполнения основного скрипта
        Response.Write("Основной скрипт продолжает выполняться<br>");
    },

    HandleStateChange: function() {
        if (XmlHttp.readyState == 4) {
            if (XmlHttp.status == 200) {
                Response.Write("Server response: " + XmlHttp.responseText + "<br>");
            } else {
                Response.Write("An error occurred: " + XmlHttp.status + " - " + XmlHttp.statusText + "<br>");
            }
        }
    }
}; */

%>
