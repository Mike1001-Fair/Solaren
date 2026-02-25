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
        ];
		const allChars = sets.join("");
		const pswd = [];

		// Получаем необходимое количество случайных значений за раз
		const randomValues = new Uint32Array(this.PswdLen);
		window.crypto.getRandomValues(randomValues);

		// По одному обязательному символу из каждого набора
		sets.forEach((set, i) => pswd.push(set[randomValues[i] % set.length]));

		// Остальное — любыми символами
		for (let i = pswd.length; i < this.PswdLen; i++) {
			pswd.push(allChars[randomValues[i] % allChars.length]);
		}

		// Перемешиваем
		return this.shuffle(pswd).join("");
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