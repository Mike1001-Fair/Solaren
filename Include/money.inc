<% //@ LANGUAGE = "JScript"
var Money = {
	ones    : ["од","дв","три","чотир","п'ят","шiст","сiм","вiсiм","дев'ят"],
	Hundreds: ["сто","двiстi","триста","чотириста","п'ятсот","шiстсот","сiмсот","вiсiмсот","дев'ятсот"],
	milion  : ["трильйон","мiльярд","мiльйон","тисяч"],
	anDan   : ["","","","сорок","","","","","дев'яносто"],
	Сurrency: "грн. ",
	Penny   : " коп.",
	Zero    : "нуль ",
	Limit   : 999999999999999,
	errMsg  : "Поза діапазоном або не є числом",

	toWord: function(num) {
		var inRange = !isNaN(num) && num >= 0 && num <= this.Limit;
		if (inRange) {
			var numParts = num.toFixed(2).split("."),
			yy, delen, sot, des, ed, forDes, forEd, ffD, forTys, oprSot, oprDes, oprEd, oprTys,
			cifR = result = "",
			cycle = 4,
			oboR = [];
			do { 
				numParts[0] = numParts[0]/1000;
				yy          = Math.floor(numParts[0]);
				delen       = Math.round((numParts[0] - yy)*1000);
				numParts[0] = yy;
				//------------------------------------------------------------------------
				sot = Math.floor(delen/100)*100;
				des = Math.floor(delen-sot) > 9 ? Math.floor((delen-sot)/10)*10 : 0;
				ed  = Math.floor(delen-sot) - Math.floor((delen-sot)/10)*10;
				//------------------------------------------------------------------------
				forDes = (des/10 == 2 ? "а" : "");
				forEd  = (ed == 1 ? "и" : (ed == 2 ? "а" : ""));
				ffD    = ((ed > 4 && ed != 7 && ed != 8 ) ? "ь" : (ed == 1 || cycle < 3 ? (cycle < 3 && ed < 2 ? "ин" : (cycle == 3 ? "на" : (cycle < 4 ? (ed == 2 ? "а" :( ed == 4 ? "и" :"")) :"на"))) : (ed == 2 ? "i" : (ed == 4 ? "и" : "" ))));
				forTys = (des/10 == 1 ? (cycle < 3 ? "iв" : "") : (cycle < 3 ? (ed == 1 ? "" : (ed > 1 && ed < 5 ? "а" :"iв")) : (ed == 1 ? "а" : (ed >1 && ed < 5 ? "i" : ""))));
				//------------------------------------------------------------------------
				oprSot = (this.Hundreds[sot/100-1] != null ? this.Hundreds[sot/100-1] : "");
				oprDes = (this.ones[des/10-1] != null ? (des/10 == 1 ? "" : (des/10 == 4 || des/10 == 9 ? this.anDan[des/10-1] : (des/10 == 2 || des/10 == 3 ? this.ones[des/10-1] + forDes + "дцять" : this.ones[des/10-1] + "десят"))) : "");
				oprEd  = (this.ones[ed-1]     != null ? this.ones[ed-1] + (des/10 == 1 ? forEd + "надцять" : ffD ) : (des == 10 ? "десять" : "") );
				oprTys = (this.milion[cycle]  != null && delen > 0  ? this.milion[cycle] + forTys : "");
				//------------------------------------------------------------------------
				cifR = oprSot + (oprDes.length > 1 ? " " + oprDes : "") + (oprEd.length > 1 ? " " + oprEd : "") + (oprTys.length > 1 ? " " + oprTys : "");
				oboR[oboR.length] = cifR;
				cycle--;
			} while (numParts[0] >= 1);  
			for (var i = oboR.length - 1; i >= 0; i--) {
				if (oboR[i] != "") {
					result += oboR[i] + " ";
				}
			}
			if (result.length < 3) result = this.Zero;
			result += this.Сurrency + numParts[1] + this.Penny;
		} return inRange ? result.replace(/  /g," ").replace(/^\s/, "") : this.errMsg
	}
}%>