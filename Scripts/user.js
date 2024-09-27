"use strict";
const User = {
	PswdLen: 10,
	PswdRe: /(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])/,

	get Pswd() {
		let Pswd = "";
		while (Pswd == "") {
			for (let i=0; i < this.PswdLen; i++) {
				Pswd += String.fromCharCode(randInt(33, 126))
			}
			if (!this.PswdRe.test(Pswd)) Pswd = "";
		}
		return Pswd;
	},

	get FileName() {
		const languageSet = ['uk'],
		userLanguage = navigator.language,
		languageCode = languageSet.includes(userLanguage) ? userLanguage : "en";
		return `client-${languageCode}.json`;
	}
};