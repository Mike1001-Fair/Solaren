"use strict";

const User = {
    //LoginRe: /^(?=.*[a-z])(?=.*[A-Z]).{8,12}$/,
	LoginRe: /^[a-zA-Z0-9._-]{8,16}$/,
	PswdRe: /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*]).{16}$/,
    PswdLen: 16,
    
    get Pswd() {
        const sets = [
            "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
            "abcdefghijklmnopqrstuvwxyz",
            "0123456789",
            "!@#$%^&*"
        ],
		allChars = sets.join("");
		let pswd = [];

		// 1. По одному обязательному символу из каждого набора
		sets.forEach(s => pswd.push(this.pick(s)));

		// 2. Остальное — любыми символами
		while (pswd.length < this.PswdLen) {
			pswd.push(this.pick(allChars));
		}

		// 3. Перемешиваем
		return this.shuffle(pswd).join("");
    },

	pick(str) {
		const r = new Uint32Array(1);
		window.crypto.getRandomValues(r);
		return str[r[0] % str.length];
	},

	shuffle(arr) {
		for (let i = arr.length - 1; i > 0; i--) {
			const r = new Uint32Array(1);
			window.crypto.getRandomValues(r);
			const j = r[0] % (i + 1);
			[arr[i], arr[j]] = [arr[j], arr[i]];
		}
		return arr;
	},

	get FileName() {
		const languageSet = ['uk'],
		userLang = navigator.language.split('-')[0],
		code = languageSet.includes(userLang) ? userLang : "en";
        return `client-${code}.json`;
    }
};