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
		if (this.JsonData) {
			return this.JsonData.Items[id] || this.ErrMsg[1]
		} else {
			console.warn(this.ErrMsg[0])
		}

	},

	GetItem(key) {
		if (this.JsonData) {
			if (this.JsonData[key])
				return this.JsonData[key]
			else {
				console.warn(this.ErrMsg[1]);
			}
		} else {
			console.warn(this.ErrMsg[0]);
		}
	}
};
