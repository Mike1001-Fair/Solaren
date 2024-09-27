<% //@ LANGUAGE = "JScript"
var Msg = Server.CreateObject("CDO.Message"),
Email = {
	SetConfig: function() {
		var url = "http://schemas.microsoft.com/cdo/configuration/";
		with (Msg.Configuration.Fields) {
			Item(url + "sendusing") = 2;
			Item(url + "smtpserver") = "epmail.slink.kiev.ua";
			Item(url + "smtpserverport") = 465;
			Item(url + "smtpusessl") = true;
			Item(url + "smtpConnectiontimeout") = 10;
			Item(url + "smtpauthenticate") = 1;
			Item(url + "sendusername") = "robot@kresc.com.ua";
			Item(url + "sendpassword") = "nG5R1GKnIUb4";
			Update();
		}
	},

	WriteConfig: function() {
		var fieldEnum = new Enumerator(Msg.Configuration.Fields);
		for (var field; !fieldEnum.atEnd(); fieldEnum.moveNext()) {
			field = fieldEnum.item();
			Response.Write(field.Name + ": " + field.Value + "<br>");
		}	

	},

	Send: function(Recipient, msgSubject, msgText) {
		try {
			with (Msg) {
				Bodypart.Charset = "utf-8";
				From = '<robot@kresc.com.ua>';
				To = Recipient;
				Subject = msgSubject;
				TextBody = msgText;
				Send(); 
			}
		} catch (ex) {
			Solaren.SysMsg(3, ex.name + ": " + ex.message)
		}
	}
}%>
