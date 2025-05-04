<% //@ LANGUAGE = "JScript"
var SessionManager = {
	FlagName: ["NewIndicator", "CheckCard"],
	FlagCount: 3,
	VarName: ["UserGUID", "UserId", "Token", "HoursLimit", "MsgText", "RoleId"],

	SetVar: function(rs) {
		var cfg  = rs.Fields("SysConfig").value,
		dbDate   = rs.Fields("OperDate").value,
		OperDate = Month.GetYMD(dbDate);

		for (var i = 0; i < this.VarName.length; i++) {
			var parameter = rs.Fields(this.VarName[i]).value;
			Session(this.VarName[i]) = Server.HTMLEncode(parameter);
		}
		
		this.SetDate(OperDate);
		this.SetFlags(cfg);
	},

	SetDate: function(OperDate) {
		var ymd  = OperDate.split("-"),
		EndDate  = new Date(ymd[0], ymd[1], 0),
		NextDate = new Date(ymd[0], +ymd[1] + 1, 0);
		Session("OperDate") = OperDate;
		Session("EndDate")  = EndDate.toStr(0);
		Session("NextDate") = NextDate.toStr(0);
	},

	SetFlags: function(cfg) {
		var index = this.FlagCount - 1;
		for (var i = 0; i < this.FlagName.length; i++) {
			Session(this.FlagName[i]) = (cfg >> (index - i)) & 1;
		}
	}
},

ConnectInfo = {
	"ADO Version": Connect.Version,
	"Connection String": Connect.ConnectionString,
	"Connection State": Connect.State,
 	"Command Timeout": Connect.CommandTimeout,
 	"Connection Timeout": Connect.ConnectionTimeout,
  	"Provider": Connect.Provider,
	"Mode": Connect.Mode,
	"Cursor Location": Connect.CursorLocation
},

SessionInfo = {
	"SESSION_COUNT": Application("SesCount"),
	"SESSION_TIMEOUT": Session.Timeout,
	"SESSION_CODEPAGE": Session.CodePage
}%>