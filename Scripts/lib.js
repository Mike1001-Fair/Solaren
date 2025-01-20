"use strict";
function GetNextDate(d) {
	const NextDate = new Date(d);
	NextDate.setDate(NextDate.getDate() + 1);
	return NextDate.toISOString().slice(0, 10);
}

//let DigitOnly = () => event.keyCode > 47 && event.keyCode < 58;
function FormateDate(strDate) {
	 return strDate.split("-").reverse().join(".");
}

function isDigit(str) {
	return /^\d+$/.test(str)
}

function Empty(str) {
	return typeof str === undefined || str === null || str === undefined || str.trim() === ''
}

function isCustomerCode(code) {
	return isEdrpoCode(code) || isPersonTaxCode(code)
}

function IntForm(num) {
	let result = '0';
	if (!isNaN(num) && num != null) {	
		result = typeof(num) == "number" ? num.toFixed(0) : num;
		result = result.replace(/(\d)(?=(\d{3})+([^\d]|$))/g,'$1 ');
	}
	return result
}

function isCreditCard(CardNumber) {   // Luhn algorithm
	const ccNumber = CardNumber.trim();
	let ChkSum = 0;
	if (/^\d{16}$/.test(ccNumber)) {
		for (let i = ccNumber.length; i > 0; i--) {
			let d = +ccNumber[i-1];
			ChkSum += i%2 ? d*2 > 9 ? d*2 - 9 : d*2 : d;
		}
	}
	return ChkSum%10 == 0
}

function isAccount(acc, mfo) {
	const k = [1,3,7,1,3,3,7,1,3,7,1,3,7,1,3,7,1,3,7],
	AccStr = mfo.slice(0, mfo.length - 1) + acc,
	AccArr = AccStr.split('');
	let ChkSum = 0;
	if (isDigit(acc) && acc.length > 5) {
		ChkSum = acc.length;
		AccArr.forEach((digit, i) => {
			if (i !== 9) {
				ChkSum += digit * k[i] % 10;
			}
		});

	}
	return ChkSum % 10 * 7 % 10 == AccArr[9]
}

function isIban(iban, mfo) {	
	let s = '', m = 0;
	if (iban.length == 29 && mfo == iban.substr(4, 6)) {
		iban = (iban.substr(4) + iban.substr(0, 4)).split('');
		iban.forEach(elm => s += parseInt(elm, 36));
		for (m = s.substr(0,15)%97, s = s.substr(15); s; s = s.substr(13)) m = (m + s.substr(0,13)) % 97;
	} return m ? m == 1 : false;
}

function isEdrpoCode(edrpo) {
	const k = [1,2,3,4,5,6,7],
	m = [3,4,5,6,7,8,9],
	edrpoInt =+ edrpo;
	let ChkSum = 0, ChkDigit = 0;
	if (isDigit(edrpo) && edrpo.length == 8 && edrpo != '00000000') {
		if (edrpoInt > 30000000 && edrpoInt < 60000000) {
			k.unshift(k.pop());
			m.unshift(m.pop());
		};
		k.forEach((elm, i) => ChkSum += edrpo[i] * elm);
		ChkDigit = ChkSum % 11;
		if (ChkDigit == 10) {
			ChkSum = 0;
			m.forEach((elm, i) => ChkSum += edrpo[i] * elm);
			ChkDigit = ChkSum % 11;
			if (ChkDigit == 10) ChkDigit = 0;
		}
	} return ChkSum ? ChkDigit == edrpo[7] : false
}

function isPersonTaxCode(code) {
	let ChkSum = 0;
	if (isDigit(code) && code.length == 10 && code != '0000000000') {
		const k = [-1,5,7,9,4,6,10,5,7];
		k.forEach((elm, i) => ChkSum += code[i] * elm)
	} return ChkSum ? ChkSum % 11 % 10 == code[9] : false
}

function isTaxCode(ipn) {
	const k = [11,13,17,19,23,29,31,37,41,43,47],
	m = [17,19,23,29,31,37,41,43,47,53,59],
	IpnArr = ipn.split('');
	let ChkSum = 0;
	if (isDigit(ipn) && ipn.length == 12 && ipn != '000000000000') {
		for (let i = 0; i < k.length; i++) {ChkSum += IpnArr[i] * k[i]};
		ChkSum = ChkSum % 11;
		if (ChkSum > 9) {
			ChkSum = 0;
			for (let i = 0; i < m.length; i++) {ChkSum += IpnArr[i] * m[i]};
			ChkSum = ChkSum % 11;
		}
	} return ChkSum ? ChkSum == IpnArr[11] : false
}

function isEICode(eic) {
	const s = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-';
	let index, ChkSum = 0;
	if (eic.length==16) {		
		for (let i=0; i<eic.length-1; i++) {ChkSum += (16-i)*s.indexOf(eic[i])};
		index = 36 - (ChkSum-1)%37;		
	} return ChkSum ? s[index]==eic[15] : false
}

function isMfoCode(mfo) {
	let result = false;
	if (isDigit(mfo) && mfo.length == 6) {
		const k = [1,3,7,1,3],
		ChkSum = k.reduce((sum, elm, i) => sum + mfo[i] * elm, 0);
		result = ChkSum % 10 * 7 % 10 == mfo[5];
	}
	return result
}

function randInt(intMin, intMax) {
	const rand = intMin + Math.random() * (intMax + 1 - intMin);
	return Math.floor(rand);
}

function utf8_to_b64(str) {
	return window.btoa(unescape(encodeURIComponent(str)));
}

function b64_to_utf8(str) {
	return decodeURIComponent(escape(window.atob(str)));
}

function getCookie(name) {	// возвращает куки с указанным name или undefined, если ничего не найдено
	let matches = document.cookie.match(new RegExp("(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)" ));
	return matches ? decodeURIComponent(matches[1]) : undefined;
}

function setCookie(name, value, options = {}) {
	options = {
		path: '/',    // при необходимости добавьте другие значения по умолчанию...options
	};

	if (options.expires instanceof Date) {
		options.expires = options.expires.toUTCString();
	}

	let updatedCookie = encodeURIComponent(name) + "=" + encodeURIComponent(value);

	for (let optionKey in options) {
		updatedCookie += "; " + optionKey;
		let optionValue = options[optionKey];
		if (optionValue !== true) {
			updatedCookie += "=" + optionValue;
		}
	}
	document.cookie = updatedCookie;
}

function deleteCookie(name) {
	setCookie(name, "", {
		'max-age': -1
	})
}

function SetDisabledOptions(Options, Disabled) {
	if (Options) {
		const options = Array.from(Options);
		options.forEach(option => option.disabled = Disabled);
		if (Disabled && Options instanceof HTMLOptionsCollection) {
			Options.selectedIndex = 0;
		}
	} else {
		throw new Error('Options must be an array or a collection of elements.');
	}
}