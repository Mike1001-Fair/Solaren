<% //@ LANGUAGE = "JScript"
var SessionManager = {
	FlagName: ["NewIndicator", "CheckCard"],

	SetVar: function(rs) {
		var cfg  = rs.Fields("SysConfig").value,
		dbDate   = rs.Fields("OperDate").value,
		OperDate = Month.GetYMD(dbDate);

		Session("UserGUID")   = rs.Fields("UserGUID").value;
		Session("UserId")     = rs.Fields("UserId").value;
		Session("Token")      = rs.Fields("Token").value;
		Session("HoursLimit") = rs.Fields("HoursLimit").value;
		Session("MsgText")    = Server.HTMLEncode(rs.Fields("MsgText").value);
		Session("RoleId")     = rs.Fields("RoleId").value;

		this.SetDate(OperDate);
		this.SetFlags(cfg, 3);
	},

	SetDate: function(OperDate) {
		var ymd  = OperDate.split("-"),
		EndDate  = new Date(ymd[0], ymd[1], 0),
		NextDate = new Date(ymd[0], +ymd[1] + 1, 0);
		Session("OperDate") = OperDate;
		Session("EndDate")  = EndDate.toStr(0);
		Session("NextDate") = NextDate.toStr(0);
	},

	SetFlags: function(cfg, flagCount) {
		var index = flagCount - 1;
		for (var i = 0; i < this.FlagName.length; i++) {
			Session(this.FlagName[i]) = (cfg >> (index - i)) & 1;
		}
	}
}%>
