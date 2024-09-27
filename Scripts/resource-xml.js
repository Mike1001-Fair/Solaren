"use strict";
const Resource = {
	path: "Resources/",
	xmlText: null,

	load(fileName) {
		fetch(this.path + fileName)
		.then(response => response.ok ? response.text() : Promise.reject(new Error(`${response.status}`)))
		.then(xmlText => {
			const parser = new DOMParser();
			this.xmlText = parser.parseFromString(xmlText, "text/xml");
		})
		.catch(error => alert(`Помилка fetch-запиту: ${error.message}`));
	},

	getText(id) {
		let result = "XML data is not loaded";
		if (this.xmlText) {
			const itemNode = this.xmlText.querySelector(`Item[id="${id}"]`);
			result = itemNode ? itemNode.textContent : "Item not found";
		} else {
			console.warn(result);
		}
		return result
	}
};