"use strict";
const Redirect = {
	"-2": "error.asp",
	"0": "accessdenied.asp",
	go(id) {
		if (Object.prototype.hasOwnProperty.call(this, id)) {
			location.href = this[id];
		}
	}
}