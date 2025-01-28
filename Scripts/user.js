"use strict";
const User = {
	PswdLen: 10,
	PswdRe: /(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])/,

	get Pswd() {
		const maxAttempts = 9;
		let pswd = "",
		valid = false;

		for (let i = 0; i < maxAttempts && !valid; i++) {
			const chars = new Array(this.PswdLen).fill().map(() => String.fromCharCode(randInt(33, 126)));
			pswd = chars.join("");
			valid = this.PswdRe.test(pswd);
		}
		return valid ? pswd : "";
	},

	get FileName() {
		const languageSet = ['uk'],
		userLanguage = navigator.language,
		languageCode = languageSet.includes(userLanguage) ? userLanguage : "en";
		return `client-${languageCode}.json`;
	}
};