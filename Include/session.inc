<% //@ LANGUAGE = "JScript"
var SessionManager = {
	SetVar: function(rs) {
		var cfg  = rs.Fields("SysConfig").value,
		dbDate   = rs.Fields("OperDate").value,
		OperDate = Month.GetYMD(dbDate),
		SysCfg   = cfg.toString(2).padStart(3, "0").split('');

		Session("UserGUID")   = rs.Fields("UserGUID").value;
		Session("UserId")     = rs.Fields("UserId").value;
		Session("Token")      = rs.Fields("Token").value;
		Session("HoursLimit") = rs.Fields("HoursLimit").value;
		Session("MsgText")    = Server.HTMLEncode(rs.Fields("MsgText").value);
		Session("RoleId")     = rs.Fields("RoleId").value;

		this.SetDate(OperDate);
		this.SetFlags(SysCfg);
	},

	SetDate: function(OperDate) {
		var ymd  = OperDate.split("-"),
		EndDate  = new Date(ymd[0], ymd[1], 0),
		NextDate = new Date(ymd[0], +ymd[1] + 1, 0);
		Session("OperDate") = OperDate;
		Session("EndDate")  = EndDate.toStr(0);
		Session("NextDate") = NextDate.toStr(0);
	},

	SetFlags: function(SysCfg) {
		var FlagName = ["NewIndicator", "CheckCard"];
		for (var i = 0; i < FlagName.length; i++) {
			Session(FlagName[i]) = +SysCfg[i] || 0;
		}
	}
}%>
