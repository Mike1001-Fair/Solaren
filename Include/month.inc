<% //@ LANGUAGE = "JScript"
var Month = {
	Name: [["сiчень","лютий","березень","квiтень","травень","червень","липень","серпень","вересень","жовтень","листопад","грудень"],
		["сiчнi","лютому","березнi","квiтнi","травнi","червнi","липнi","серпнi","вереснi","жовтнi","листопадi","груднi"],
		["сiчня","лютого","березня","квiтня","травня","червня","липня","серпня","вересня","жовтня","листопада","грудня"]],
	Quarter: [{1:"Сiчень",2:"Лютий",3:"Березень"}, {4:"Квiтень",5:"Травень",6:"Червень"}, {7:"Липень",8:"Серпень",9:"Вересень"}, {10:"Жовтень",11:"Листопад",12:"Грудень"}],
	YearItem: "року",

	isPeriod: function(StartDate, EndDate) {
		return StartDate.isDate() && EndDate.isDate() ? StartDate.toDate() <= EndDate.toDate() : 0
	},

	GetLastDay: function(mstr) {
		var ym = mstr.split("-"),
		d = new Date(ym[0], ym[1], 0),
		result = [d.getDate(), this.Name[2][ym[1]-1], ym[0], this.YearItem];
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
		result = ["1 ", this.Name[2][ym[1]-1], ym[0], this.YearItem];
		return result.join(" ");
	},

	GetPeriod: function(mstr, index) {
		var ym = mstr.split("-"),
		result = [this.Name[index][ym[1]-1], ym[0], this.YearItem];
		return result.join(" ");
	},
	
	GetDate: function(dstr, index) {
		var ymd = dstr.split("-");
		result = [ymd[2], this.Name[index][ymd[1]-1], ymd[0], this.YearItem];
		return result.join(" ");
	}
}%>
