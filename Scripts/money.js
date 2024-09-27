"use strict";
const Money = {
	cifir   : ["од","дв","три","чотир","п'ят","шiст","сiм","вiсiм","дев'ят"],
	sotN    : ["сто","двiстi","триста","чотириста","п'ятсот","шiстсот","сiмсот","вiсiмсот","дев'ятсот"],
	milion  : ["трильйон","мiльярд","мiльйон","тисяч"],
	anDan   : ["","","","сорок","","","","","дев'яносто"],
	Сurrency: "грн. ",
	Penny   : " коп.",
	Zero    : "нуль ",
	Limit   : 999999999999999,
	errMsg  : "Поза діапазоном",

	toDelimited(Num) {
		let Result = "0,00";
		if (!isNaN(Num)) {
			let ar = typeof(Num) == "number" ? Num.toFixed(2).split(".") : Num.split(".");
			Result = ar[0].replace(/(\d)(?=(\d{3})+([^\d]|$))/g,"$1 ") + "," + ar[1];
		}
		return Result
	},

	toWord(Num) {
		const inRange = !isNaN(num) && Num >= 0 && Num <= this.Limit;
		if (inRange) {
			let ar = Num.toFixed(2).split("."),
			yy, delen, sot, des, ed, forDes, forEd, ffD, forTys, oprSot, oprDes, oprEd, oprTys,
			cifR = Result = "",
			cycle = 4,
			oboR = [];
			do { 
				ar[0] = ar[0]/1000;
				yy    = Math.floor(ar[0]);
				delen = Math.round((ar[0]-yy)*1000);
				ar[0] = yy;
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
				oprSot = (this.sotN[sot/100-1] != null ? this.sotN[sot/100-1] : "");
				oprDes = (this.cifir[des/10-1] != null ? (des/10 == 1 ? "" : (des/10 == 4 || des/10 == 9 ? this.anDan[des/10-1] : (des/10 == 2 || des/10 == 3 ? this.cifir[des/10-1] + forDes + "дцять" : this.cifir[des/10-1] + "десят"))) : "");
				oprEd  = (this.cifir[ed-1]     != null ? this.cifir[ed-1] + (des/10 == 1 ? forEd + "надцять" : ffD ) : (des == 10 ? "десять" : "") );
				oprTys = (this.milion[cycle]   != null && delen > 0  ? this.milion[cycle] + forTys : "");
				//------------------------------------------------------------------------
				cifR = oprSot + (oprDes.length > 1 ? " " + oprDes : "") + (oprEd.length > 1 ? " " + oprEd : "") + (oprTys.length > 1 ? " " + oprTys : "");
				oboR[oboR.length] = cifR;
				cycle--;
			} while (ar[0] >= 1);  
			for (let i = oboR.length - 1; i >= 0; i--) {
				if (oboR[i] != "") Result += oboR[i] + " ";
			}
			if (Result.length < 3) Result = this.Zero; 
			Result += this.Сurrency + ar[1] + this.Penny;
		} return inRange ? Result.replace(/  /g," ").replace(/^\s/, "") : this.errMsg
	}
};