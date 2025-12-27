"use strict";
const Resource = {
	Version: "v=2.2",
	Path: "Resources/",
	JsonData: null,
	ErrText: ["JSON data is not loaded", "Item not found"], 

	get ErrMsg() {
		const index = this.JsonData ? 1 : 0;
		return this.ErrText[index]
	},

	Load(fileName) {
		const fullName = `${this.Path}${fileName}?${this.Version}`;
		document.body.style.cursor = "progress";
		fetch(fullName)
		.then(response => response.ok ? response.json() : Promise.reject(new Error(`${response.status}`)))
		.then(jsondata => this.JsonData = jsondata)
		.catch(error => console.warn(`Fetch request error: ${error.message}`))
		.finally(() => document.body.style.cursor="auto");
	},

	GetText(id) {
		return this.JsonData?.Items?.[id] ?? console.warn(this.ErrMsg);
	},

	GetItem(key) {
		return this.JsonData?.[key] ?? console.warn(this.ErrMsg);
	}
};