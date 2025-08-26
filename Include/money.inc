<% //@ LANGUAGE = "JScript"
var Money = {
	ones    : ["од", "дв", "три", "чотир", "п'ят", "шіст", "сім", "вісім", "дев'ят"],
	Hundreds: ["сто", "двісті", "триста", "чотириста", "п'ятсот", "шістсот", "сімсот", "вісімсот", "дев'ятсот"],
	milion  : ["трильйон", "мільярд", "мільйон", "тисяч"],
	anDan   : ["", "", "", "сорок", "", "", "", "", "дев'яносто"],
	Currency: "грн.",
	Penny   : "коп.",
	Zero    : "нуль",
	Limit   : 999999999999999,
	errMsg  : "Поза діапазоном або не є числом",

	inRange: function(num) {
		return !isNaN(num) && num >= 0 && num <= this.Limit
	},

	toWord: function(num) {
		var inRange = this.inRange(num),
		result;
		if (inRange) {
			var numParts = typeof(num) == "number" ? num.toFixed(2).split(".") : num.split("."),
			cycle = this.milion.length,
			chunk,
			word = [];
			do {
				chunk = this.processChunk(numParts[0] % 1000, cycle);
				if (chunk) {
					word.push(chunk);
				}
				numParts[0] = Math.floor(numParts[0] / 1000);
				cycle--;
			} while (numParts[0] > 0); 
			result = [word.length > 0 ? word.reverse().join(" ") : this.Zero, this.Currency, numParts[1], this.Penny];
		}
		return inRange ? result.join(" ") : this.errMsg
	},

	processChunk: function (currentPart, cycle) {
		var sot = Math.floor(currentPart / 100),
		des = Math.floor((currentPart % 100) / 10),
		ed = currentPart % 10,
		//------------------------------------------------------------------------
		forDes = des == 2 ? "а" : "",
		forEd  = ed == 1 ? "и" : (ed == 2 ? "а" : ""),
		ffD    = this.getOnesSuffix(ed, cycle),
		forTys = this.getGroupSuffix(des, ed, cycle),
		//------------------------------------------------------------------------
		oprSot = this.Hundreds[sot - 1] || "",
		oprDes = this.getTensText(des, forDes),
		oprEd  = this.ones[ed - 1] ? this.ones[ed-1] + (des == 1 ? forEd + "надцять" : ffD) : (des == 1 ? "десять" : ""),
		oprTys = this.milion[cycle] && currentPart > 0  ? this.milion[cycle] + forTys : "";
		return [oprSot, oprDes, oprEd, oprTys].join(" ").trim();
	},
	
	getOnesSuffix: function(ed, cycle) {
		return (ed > 4 && ed != 7 && ed != 8) ? "ь" :
			(ed == 1 || cycle < 3 ? (cycle < 3 && ed < 2 ? "ин" :
			(cycle == 3 ? "на" :
			(cycle < 4 ? (ed == 2 ? "а" :
			(ed == 4 ? "и" : "")) : "на"))) :
			(ed == 2 ? "і" : (ed == 4 ? "и" : "")))
		
	},

	getGroupSuffix: function(des, ed, cycle) {
		return des == 1 ? (cycle < 3 ? "ів" : "") :
			(cycle < 3 ? (ed == 1 ? "" : ed > 1 && ed < 5 ? "а" : "ів") :
			(ed == 1 ? "а" : ed > 1 && ed < 5 ? "і" : ""))
	},

	getTensText: function(des, forDes) {
		return this.ones[des - 1] ? (des == 1 ? "" :
			(des == 4 || des == 9 ? this.anDan[des - 1] :
			(des == 2 || des == 3 ? this.ones[des - 1] + forDes + "дцять" :
			this.ones[des - 1] + "десят"))) : ""
	}
}%>