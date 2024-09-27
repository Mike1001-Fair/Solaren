<% //@ LANGUAGE = "JScript"
var RecordSet = Server.CreateObject("ADODB.Recordset"),
DataSet = {
	GetRecord: function() {
		with (RecordSet) {
			ActiveConnection = Connect;
			CursorLocation   = adUseClient;
			//CursorType       = adOpenStatic;
			LockType         = adLockReadOnly;
			Open(Cmd);
		}
	}
}%>