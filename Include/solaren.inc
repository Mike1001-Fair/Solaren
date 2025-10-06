<% //@ LANGUAGE = "JScript"
var Cmd = Server.CreateObject("ADODB.Command"),
Connect = Server.CreateObject("ADODB.Connection"),
Solaren = {
	ConnectMode: adModeRead,
	ConnectionTimeout: 10,
	CommandTimeout: 20,
	ScriptName: String(Request.ServerVariables("SCRIPT_NAME")) || "",
	Referer: String(Request.ServerVariables("HTTP_REFERER")) || "",
	Method : String(Request.ServerVariables("REQUEST_METHOD")) || "",

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

	Map: function(Collection) {
		var result = {};
		if (this.ValidObject(Collection)) {			
			for (var items = new Enumerator(Collection); !items.atEnd(); items.moveNext()) {
				var item = items.item(),
				hasName = item && typeof item.Name === "string",
				key = hasName ? item.Name : item;
				value = hasName ? item.Value : Collection(item);
				result[key] = value;
				//this.Write("<br>key:" + key + ", value:" + value + ", typeof item.Name:" + typeof item.Name);
			}
		}
		return result;
	},

	Write: function(info) {
		Response.Charset = "utf-8";
		Response.Write(info);
	},

	Match: function(key) {
		//this.Write('<br>' + key);
		return this.Referer.indexOf(key) > -1;
	},

	Collection: function() {
		return this.Method == "POST" ? Request.Form : Request.QueryString;
	},

	Parse: function() {
		var collection = this.Collection();
		return this.Match(Application("AppName")) ? this.Map(collection) : {};
	}
}%>