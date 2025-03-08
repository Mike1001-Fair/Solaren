"use strict";
const Redirect = {
	"-2": "error.asp",
	"0": "accessdenied.asp",
	go(id) {
		if (this[id]) {
			location.href = this[id];
		}
	}
}