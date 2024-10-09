<% //@ LANGUAGE = "JScript"
var Cmd = Server.CreateObject("ADODB.Command"),
Connect = Server.CreateObject("ADODB.Connection"),
Solaren = {
	ConnectMode: 1,
	ConnectionTimeout: 10,
	CommandTimeout: 20,
	RequestMethod: Request.ServerVariables("REQUEST_METHOD"),

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

	SetSessionVar: function(cfg) {
		var SesVar = ["NewIndicator", "CheckCard"];
		for (var i = 0; i < SesVar.length; i++) {
			Session(SesVar[i]) =+ cfg[i] || 0;
		}
	},

	GetRandInt: function(intMin, intMax) {
		var rand = intMin + Math.random() * (intMax + 1 - intMin);
		return Math.floor(rand);
	},

	GetErrMsg: function(ex) {
		var ErrMsg = "Runtime Error ";
		if (typeof ex == 'object' && ex != null) {
			if (ex instanceof Error) {
				for (var i = 0; i < Connect.Errors.Count; i++) {
					ErrMsg += Connect.Errors(i).number + ": " + Connect.Errors(i).description + "\n";				
				}
			} else ErrMsg += ex.name + ": " + ex.message;
		} else throw ex;
		return ErrMsg
	},

	SysMsg: function(msgType, msgText) {
		var Page = ["errmsg", "done", "accessdenied", "error"];
		if (!Page[msgType]) {
			msgType = Page.length - 1 // if out of range - default last page
			msgText = "Runtime Error: out of range";			
		}
		Session("SysMsg") = msgText;
		Session("ScriptName") = String(Request.ServerVariables("SCRIPT_NAME"));
		Response.Redirect(Page[msgType] + ".asp");
	},

	EOF: function(rs, msg) {
		if (rs.EOF) {
			rs.Close();
			Connect.Close();
			this.SysMsg(0, msg);
		}
	},	

	HTTPMethod: function(method, paramCount) {
		var totalParams = Request.QueryString.Count + Request.Form.Count;
		/*Response.Write("RequestMethod = " + this.RequestMethod +
			"<br>Request.QueryString.Count = " + Request.QueryString.Count + 
			"<br>Request.Form.Count = " + Request.Form.Count +
			"<br>totalParams = " + totalParams +
			"<br>" + (String(this.RequestMethod) === method)
		);*/
		return this.RequestMethod == method && totalParams == paramCount
	},

	Empty: function(testvar) {
		return testvar == undefined || testvar == null;
	}
}%>