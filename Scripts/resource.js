"use strict";
const Resource = {
	JsonData: null,
	ErrMsg: ["JSON data is not loaded", "Item not found"], 

	get Msg() {
		return this.ErrMsg[this.JsonData ? 1 : 0]
	},

	Load(fileName) {
		const Version = "v=2.2",
		Path = "Resources/",
		fullName = `${Path}${fileName}?${Version}`;

		document.body.style.cursor = "progress";
		fetch(fullName)
		.then(response => response.ok ? response.json() : Promise.reject(new Error(`${response.status}`)))
		.then(jsondata => this.JsonData = jsondata)
		.catch(error => console.warn(`Fetch request error: ${error.message}`))
		.finally(() => document.body.style.cursor="auto");
	},

	GetText(id) {
		return this.JsonData?.Items?.[id] ?? console.warn(this.Msg);
	},

	GetItem(key) {
		return this.JsonData?.[key] ?? console.warn(this.Msg);
	}
};