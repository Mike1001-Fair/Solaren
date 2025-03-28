<% //@ LANGUAGE = "JScript"
var Cmd = Server.CreateObject("ADODB.Command"),
Connect = Server.CreateObject("ADODB.Connection"),
Solaren = {
	ConnectMode: adModeRead,
	ConnectionTimeout: 10,
	CommandTimeout: 20,
	ScriptName: String(Request.ServerVariables("SCRIPT_NAME")),

	SetCmd: function(spName) {
		Connect.Mode = this.ConnectMode;
		Connect.ConnectionTimeout = this.ConnectionTimeout;
		Connect.Open(Application("ConnectString"));
		with (Cmd) {
			CommandType      = adCmdStoredProc;
			CommandText      = spName;
			CommandTimeout   = this.CommandTimeout;
			ActiveConnection = Connect;
		}
	},

	Execute: function(spName, msg) {
		Cmd.CommandText = spName;
		var rs = Cmd.Execute();
		this.EOF(rs, msg);
		return rs
	},

	EOF: function(rs) {
		if (rs.EOF) {
			rs.Close();
			this.Close();
			Resource.Load(User.ResourceFile());
			Message.Write(0, Dictionary.Item("InfoNotFound"));
		}
	},	

	Close: function() {
		if (Connect.State) {
			Connect.Close();
		}
	},

	GetRandInt: function(intMin, intMax) {
		var rand = intMin + Math.random() * (intMax + 1 - intMin);
		return Math.floor(rand);
	},


	Empty: function(testvar) {
		return testvar == undefined || testvar == null;
	},

	ValidObject: function(obj) {
		return obj && typeof obj === 'object'
	}
}%>