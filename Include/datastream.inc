<% //@ LANGUAGE = "JScript"
var Stream = Server.CreateObject("ADODB.Stream"),
DataStream = {
	Open: function(StreamCharSet, StreamType) {
		with (Stream) {
			Type    = StreamType;
			CharSet = StreamCharSet;
			Open();
		}
	}
}%>
