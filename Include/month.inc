<% //@ LANGUAGE = "JScript"
var Month = {
	Name: ["сiч", "лют", "берез", "квiт", "трав", "черв", "лип", "серп", "верес", "жовт", "листопад", "груд"],

	Quarter: [
		{1 : "Сiчень", 2 : "Лютий", 3 : "Березень"},
		{4 : "Квiтень", 5 : "Травень", 6 : "Червень"},
		{7 : "Липень", 8 : "Серпень", 9 : "Вересень"},
		{10 : "Жовтень", 11 : "Листопад", 12 : "Грудень"}
	],

	Date: ["2015-01-01", Session("OperDate"), Session("EndDate"), Session("NextDate"), "9999-12-31"],

	YearItem: "року",

	GetName: function(monthNum, caseType) {
		var suffix = "";
		if (caseType == 0) {
			suffix = monthNum == 1 ? "ий" : monthNum == 10 ? "" : "ень";
		} else if (caseType == 1) {
			suffix = monthNum == 1 ? "ому" : monthNum == 10 ? "і" : "ні";
		} else if (caseType == 2) {
			suffix = monthNum == 1 ? "ого" : monthNum == 10 ? "а" : "ня";
		} else {
			suffix = "";
		}
		return this.Name[monthNum] + suffix
	},

	GetMonth: function(index) {
		return this.Date[index].slice(0, 7)
	},

	isPeriod: function(StartDate, EndDate) {	// StartDate, EndDate is string type yyyy-mm-dd
		return StartDate.isDate() && EndDate.isDate() ? StartDate.toDate() <= EndDate.toDate() : 0
	},

	GetLastDay: function(mstr) {
		var ym = mstr.split("-"),
		monthNum = +ym[1] - 1,
		monthName = this.GetName(monthNum, 2),
		d = new Date(ym[0], ym[1], 0),
		result = [d.getDate(), monthName, ym[0], this.YearItem];
		return result.join(" ");
	},

	GetShortLastDay: function(mstr) {
		var ym = mstr.split("-"),
		d = new Date(ym[0], ym[1], 0),
		dmy = [d.getDate(), d.getMonth() + 1, d.getFullYear()];
		dmy.padZero();
		return dmy.join('.')		
	},

	GetFirstDay: function(mstr) {
		var ym = mstr.split("-"),
		monthNum = +ym[1] - 1,
		monthName = this.GetName(monthNum, 2),
		result = ["1 ", monthName, ym[0], this.YearItem];
		return result.join(" ");
	},

	GetPeriod: function(mstr, caseType) {
		var ym = mstr.split("-"),
		monthNum = +ym[1] - 1,
		monthName = this.GetName(monthNum, caseType),
		result = [this.GetName(monthNum, caseType), ym[0], this.YearItem];		
		return result.join(" ");
	},
	
	GetDate: function(dstr, caseType) {
		var ymd = dstr.split("-"),
		monthNum = +ymd[1] - 1,
		monthName = this.GetName(monthNum, caseType);
		result = [ymd[2], monthName, ymd[0], this.YearItem];
		return result.join(" ");
	}
}%>