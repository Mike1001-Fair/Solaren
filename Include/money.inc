<% //@ LANGUAGE = "JScript"
var Money = {
	ones    : ["од","дв","три","чотир","п'ят","шiст","сiм","вiсiм","дев'ят"],
	Hundreds: ["сто","двiстi","триста","чотириста","п'ятсот","шiстсот","сiмсот","вiсiмсот","дев'ятсот"],
	milion  : ["трильйон","мiльярд","мiльйон","тисяч"],
	anDan   : ["","","","сорок","","","","","дев'яносто"],
	Сurrency: " грн. ",
	Penny   : " коп.",
	Zero    : "нуль ",
	Limit   : 999999999999999,
	errMsg  : "Поза діапазоном або не є числом",

	toWord: function(num) {
		var inRange = !isNaN(num) && num >= 0 && num <= this.Limit;
		if (inRange) {
			var numParts = num.toFixed(2).split("."),
			cycle = 4,
			chunk,
			word = [],
			result;
			do {
				chunk = this.processChunk(numParts[0] % 1000, cycle);
				if (chunk != "") word.push(chunk);
				numParts[0] = Math.floor(numParts[0] / 1000);
				cycle--;
			} while (numParts[0] > 0); 
			result = [word.length > 0 ? word.reverse().join(" ") : this.Zero, this.Сurrency, numParts[1], this.Penny];
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
			(ed == 2 ? "i" : (ed == 4 ? "и" : "")))
		
	},

	getGroupSuffix: function(des, ed, cycle) {
		return des == 1 ? (cycle < 3 ? "iв" : "") :
			(cycle < 3 ? (ed == 1 ? "" : ed > 1 && ed < 5 ? "а" : "iв") :
			(ed == 1 ? "а" : ed > 1 && ed < 5 ? "i" : ""))
	},

	getTensText: function(des, forDes) {
		return this.ones[des - 1] ? (des == 1 ? "" :
			(des == 4 || des == 9 ? this.anDan[des - 1] :
			(des == 2 || des == 3 ? this.ones[des - 1] + forDes + "дцять" :
			this.ones[des - 1] + "десят"))) : ""
	}
}%>