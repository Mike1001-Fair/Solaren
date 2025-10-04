"use strict";
const Redirect = {
	"-2": "error.asp",
	"0": "accessdenied.asp",
	go(id) {
		if (id in this) {
		//if (Object.prototype.hasOwnProperty.call(this, id)) {
			location.href = this[id];
		}
	}
}