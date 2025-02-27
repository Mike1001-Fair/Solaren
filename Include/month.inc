﻿<% //@ LANGUAGE = "JScript"
var Month = {
	Name: ["сiч", "лют", "берез", "квiт", "трав", "черв", "лип", "серп", "верес", "жовт", "листопад", "груд"],
	Date: ["2015-01-01", Session("OperDate"), Session("EndDate"), Session("NextDate"), "9999-12-31"],
	YearItem: "року",

	Quarter: function() {
		var Quarter = [];
		for (var i = 0; i < this.Name.length; i += 3) {
			var Item = {};
			for (var j = 0; j < 3; j++) {
				Item[i + j + 1] = this.GetName(i + j, 0);
			}
			Quarter.push(Item);
		}
		return Quarter;
	},

	GetName: function(index, caseType) {
		var suffix = {
			1:  ["ий", "ому", "ого"],
			10: ["", "і", "а"],
			def: ["ень", "ні", "ня"]
		},
		suffixList = suffix[index] || suffix.def;
		return this.Name[index] + suffixList[caseType];
	},

	GetMonth: function(index) {
		var dateItem = this.Date[index];
		return dateItem ? dateItem.slice(0, 7) : "";
	},

	isPeriod: function(StartDate, EndDate) {	// StartDate, EndDate is string type yyyy-mm-dd
		return StartDate.isDate() && EndDate.isDate() ? StartDate.toDate() <= EndDate.toDate() : 0
	},

	GetLastDay: function(mstr) {
		var ym = mstr.split("-"),
		index = ym[1] - 1,
		monthName = this.GetName(index, 2),
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
		index = ym[1] - 1,
		monthName = this.GetName(index, 2),
		result = ["1 ", monthName, ym[0], this.YearItem];
		return result.join(" ");
	},

	GetPeriod: function(mstr, caseType) {
		var ym = mstr.split("-"),
		index = ym[1] - 1,
		monthName = this.GetName(index, caseType),
		result = [monthName, ym[0], this.YearItem];		
		return result.join(" ");
	},
	
	GetDate: function(dstr, caseType) {
		var ymd = dstr.split("-"),
		index = ymd[1] - 1,
		monthName = this.GetName(index, caseType),
		result = [ymd[2], monthName, ymd[0], this.YearItem];
		return result.join(" ");
	},

	GetYMD: function(dbDate) {
		var result = new Date(dbDate);
		return result.toStr(0)
	}
}%>