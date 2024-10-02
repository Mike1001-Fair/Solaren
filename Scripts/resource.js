"use strict";
const Resource = {
	Version: "v=2.1",
	Path: "Resources/",
	JsonData: null,
	ErrMsg: ["JSON data is not loaded", "Item not found"], 

	Load(fileName) {
		fetch(`${this.Path}${fileName}?${this.Version}`)
		.then(response => response.ok ? response.json() : Promise.reject(new Error(`${response.status}`)))
		.then(jsondata => this.JsonData = jsondata)
		.catch(error => console.warn(`Fetch request error: ${error.message}`));
	},

	GetText(id) {
		return this.JsonData?.Items?.[id] || console.warn(this.ErrMsg[this.JsonData ? 1 : 0]);
	},

	GetItem(key) {
		return this.JsonData?.[key] || console.warn(this.ErrMsg[this.JsonData ? 1 : 0]);
	}
};