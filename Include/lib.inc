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

	SetSessionVar: function(rs) {
		var cfg  = rs.Fields("SysConfig").value,
		dbDate   = rs.Fields("OperDate").value,
		OperDate = Month.GetYMD(dbDate),
		SysCfg   = cfg.toString(2).padStart(3, "0").split('');

		Session("UserGUID")   = rs.Fields("UserGUID").value;
		Session("UserId")     = rs.Fields("UserId").value;
		Session("Token")      = rs.Fields("Token").value;
		Session("HoursLimit") = rs.Fields("HoursLimit").value;
		Session("MsgText")    = rs.Fields("MsgText").value;
		Session("RoleId")     = RoleId;

		this.SetSessionDate(OperDate);
		this.SetSessionFlags(SysCfg);
	},

	SetSessionDate: function(OperDate) {
		var ymd  = OperDate.split("-"),
		EndDate  = new Date(ymd[0], ymd[1], 0),
		NextDate = new Date(ymd[0], +ymd[1] + 1, 0);
		Session("OperDate") = OperDate;
		Session("EndDate")  = EndDate.toStr(0);
		Session("NextDate") = NextDate.toStr(0);
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
		var ErrMsg = [];
		if (this.ValidObject(ex)) {
			if (Connect.Errors.Count) {
				for (var i = 0; i < Connect.Errors.Count; i++) {
					var row = [Connect.Errors(i).number, Connect.Errors(i).description];
					ErrMsg.push(row.join(": "));
				}
			} else {
				ErrMsg.push(ex.name + ": " + ex.message);
			}
		} else {
			ErrMsg.push("Unknown exception");
		}
		return ErrMsg.join("\n")
	},

	SysMsg: function(msgType, msgText) {
		var Page = ["errmsg", "done", "accessdenied", "error"];
		if (!Page[msgType]) {
			msgType = Page.length - 1 // if out of range - default error page
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

	Empty: function(testvar) {
		return testvar == undefined || testvar == null;
	},

	ValidObject: function(obj) {
		return obj && typeof obj === 'object'
	}
}%>