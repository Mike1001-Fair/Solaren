<% //@ LANGUAGE = "JScript"
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
		return (this.Date[index] || "").slice(0, 7);
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

	GetRange: function(BegDate, EndDate) {
		var isDate = BegDate.isDate() && EndDate.isDate(),
		range = [isDate ? BegDate.formatDate("-") : this.GetPeriod(BegDate, 0)];
		if (BegDate != EndDate) {
			range.push(isDate ? EndDate.formatDate("-") : this.GetPeriod(EndDate, 0));
		}
		return range.join(' &ndash; ');
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
	},

	Flip: function(mstr) {
		return mstr.split("-").reverse().join("-")
	},

	WriteDate: function() {
		var ResponseText = ['<FIELDSET><LEGEND>Дата</LEGEND>',
			'<LABEL>З <INPUT TYPE="date" NAME="BegDate" VALUE="' + this.Date[1] +
			'" MIN="' + this.Date[0] + '" MAX="' + this.Date[3] +	'" REQUIRED></LABEL>',
			'</FIELDSET>\n'
		];
		Response.Write(ResponseText.join("\n"));
	},

	WriteDatePeriod: function(legend, begDate, endDate, minDate, maxDate) {
		var ResponseText = ['<FIELDSET>', '<LEGEND>' + legend + '</LEGEND>',
			'<INPUT TYPE="date" NAME="BegDate" VALUE="' + begDate +
			'" MIN="' + minDate + '" MAX="' + maxDate + '" REQUIRED> &#8722;',
			'<INPUT TYPE="date" NAME="EndDate" VALUE="' + endDate +
			'" MIN="' + minDate + '" MAX="' + maxDate + '" REQUIRED>',
			'</FIELDSET>\n'
		];
		Response.Write(ResponseText.join("\n"));
	},

	WritePeriod: function() {
		var OperMonth = this.GetMonth(1),
		MinMonth = this.GetMonth(0),
		ResponseText = ['<FIELDSET><LEGEND>Перioд</LEGEND>',
			'<INPUT TYPE="Month" NAME="BegMonth" VALUE="' + OperMonth +
			'" MIN="' + MinMonth + '" MAX="' + OperMonth + '" REQUIRED> &#8722;',
			'<INPUT TYPE="Month" NAME="EndMonth" VALUE="' + OperMonth +
			'" MIN="' + MinMonth  +	'" MAX="' + OperMonth +	'" REQUIRED>',
			'</FIELDSET>\n'
		];
		Response.Write(ResponseText.join("\n"));
	}
}%>