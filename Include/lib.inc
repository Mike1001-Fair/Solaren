<% //@ LANGUAGE = "JScript"
var Cmd = Server.CreateObject("ADODB.Command"),
Connect = Server.CreateObject("ADODB.Connection"),
Solaren = {
	ConnectMode: 1,
	ConnectionTimeout: 10,
	CommandTimeout: 20,
	RequestMethod: Request.ServerVariables("REQUEST_METHOD"),
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

	GetYMD: function(dbDate) {
		var result = new Date(dbDate);
		return result.toStr()
	},

	SetSessionVar: function(rs) {
		var cfg  = rs.Fields("SysConfig").value,
		dbDate   = rs.Fields("OperDate").value,
		OperDate = this.GetYMD(dbDate),
		ymd      = OperDate.split("-"),
		Today    = new Date(),
		EndDate  = new Date(ymd[0], ymd[1], 0),
		NextDate = new Date(ymd[0], +ymd[1] + 1, 0),
		SysCfg   = cfg.toString(2).padStart(3, "0").split('');

		Session("UserGUID")   = rs.Fields("UserGUID").value;
		Session("UserId")     = rs.Fields("UserId").value;
		Session("Token")      = rs.Fields("Token").value;
		Session("HoursLimit") = rs.Fields("HoursLimit").value;
		Session("MsgText")    = rs.Fields("MsgText").value;
		Session("RoleId")     = RoleId;
		Session("OperDate")   = OperDate;
		Session("OperMonth")  = OperDate.slice(0, 7);
		Session("Today")      = Today.toStr();
		Session("EndDate")    = EndDate.toStr();
		Session("NextDate")   = NextDate.toStr();

		this.SetSessionFlags(SysCfg);
	},

	SetSessionFlags: function(SysCfg) {
		var FlagName = ["NewIndicator", "CheckCard"];
		for (var i = 0; i < FlagName.length; i++) {
			Session(FlagName[i]) = +SysCfg[i] || 0;
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
		Session("ScriptName") = this.ScriptName;
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
		return this.RequestMethod == method && totalParams == paramCount
	},

	Empty: function(testvar) {
		return testvar == undefined || testvar == null;
	}
}%>