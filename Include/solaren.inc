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
		Cmd.CommandType = adCmdStoredProc;
		Cmd.CommandText = spName;
		Cmd.CommandTimeout = this.CommandTimeout;
		Cmd.ActiveConnection = Connect;
	},

	Execute: function(spName, msg) {
		Cmd.CommandText = spName;
		var rs = Cmd.Execute();
		this.EOF(rs, msg);
		return rs
	},

	EOF: function(rs, msg) {
		if (rs.EOF) {
			rs.Close();
			this.Close();
			if (!msg) {
				Resource.Load(User.ResourceFile());
				var resourceText = Dictionary.Item("InfoNotFound");
			}
			Message.Write(0, msg || resourceText);
		}
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
	},

	Map: function(source) {
		var result = {};
		try {			
			for (var items = new Enumerator(source); !items.atEnd(); items.moveNext()) {
				var item = items.item(),
				hasName = typeof item.Name !== "undefined",
				key = hasName ? item.Name : item;
				value = hasName ? item.Value : source(item);
				result[key] = value;
				//Response.Write("key:" + key + ", value:" + value + ", typeof item.Name:" + typeof item.Name + "<br>" );
			}
		} catch (ex) {
			Message.Write(3, Message.Error(ex))
		}
		return result;
	}
}%>