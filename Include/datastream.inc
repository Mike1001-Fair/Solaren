<% //@ LANGUAGE = "JScript"
var Stream = Server.CreateObject("ADODB.Stream"),
DataStream = {
	Open: function(StreamCharSet, StreamType) {
		with (Stream) {
			CharSet = StreamCharSet;
			Type    = StreamType;
			Open();
		}
	}
}%>
