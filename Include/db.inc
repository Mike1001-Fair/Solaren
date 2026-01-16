<% //@ LANGUAGE = "JScript"
var Cmd = Server.CreateObject("ADODB.Command"),
Connect = Server.CreateObject("ADODB.Connection"),
Db = {
	SetCmd: function(spName) {
		Connect.Mode = adModeRead;
		Connect.ConnectionTimeout = 10;
		Connect.Open(Application("ConnectString"));
		Cmd.CommandType = adCmdStoredProc;
		Cmd.CommandText = spName;
		Cmd.CommandTimeout = 20;
		Cmd.ActiveConnection = Connect;
	},

	Execute: function(spName, msg) {
		Cmd.CommandText = spName;
		var rs = Cmd.Execute();
		return rs.EOF ? this.EOF(rs, msg) : rs
	},

	EOF: function(rs, msg) {
		rs.Close();
		this.Close();
		if (!msg) {
			Resource.Load(User.ResourceFile());
			var resourceText = Dictionary.Item("InfoNotFound");
		}
		Message.Write(0, msg || resourceText);
	},	

	Close: function() {
		if (Connect.State) {
			Connect.Close();
		}
	},

	DelParameters: function() {
		var count = Cmd.Parameters.Count || 0;
		for (var i = count - 1; i >= 0; i--) {
			Cmd.Parameters.Delete(i);
		}
	}
}%>