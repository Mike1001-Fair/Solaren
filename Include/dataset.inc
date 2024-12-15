<% //@ LANGUAGE = "JScript"
var RecordSet = Server.CreateObject("ADODB.Recordset"),
DataSet = {
	Open: function(Cmd) {
		with (RecordSet) {
			ActiveConnection = Connect;
			CursorLocation   = adUseClient;
			//CursorType       = adOpenStatic;
			LockType         = adLockReadOnly;
			Open(Cmd);
		}
	}
}%>