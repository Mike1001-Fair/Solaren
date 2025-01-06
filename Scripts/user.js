"use strict";
const User = {
	PswdLen: 10,
	PswdRe: /(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])/,

	get Pswd() {
		const maxAttempts = 10;
		let pswd = "";
		for (let i = 0; i < maxAttempts && pswd == ""; i++) {
			let chars = [];
			for (let j = 0; j < this.PswdLen; j++) {
				chars.push(String.fromCharCode(randInt(33, 126)))
			}
			pswd = chars.join("");
			if (!this.PswdRe.test(pswd)) {
				pswd = "";
			}
		}
		return pswd;
	},

	get FileName() {
		const languageSet = ['uk'],
		userLanguage = navigator.language,
		languageCode = languageSet.includes(userLanguage) ? userLanguage : "en";
		return `client-${languageCode}.json`;
	}
};