<% //@ LANGUAGE = "JScript"
with (Date) {
	prototype.toStr = function() {
		var ymd = [this.getFullYear(), this.getMonth() + 1, this.getDate()];
		ymd.padZero();
		return ymd.join("-")
	}
}

with (String) {
	prototype.toDMY = function() {
		return this.split("-").reverse().join(".")
	}

	prototype.isDate = function () {
		return /^\d{4}-\d{2}-\d{2}(T\d{2}:\d{2}:\d{2})?$/.test(this)
	}

	prototype.toDate = function() {
		var dt   = this.split('T'),
		DateOnly = dt.length == 1,
		ymd      = dt[0].split('-');
		if (!DateOnly) {
			var hms = dt[1].split(':');
		}
		return DateOnly ? new Date(ymd[0], ymd[1] - 1, ymd[2]) : new Date(ymd[0], ymd[1]-1, ymd[2], hms[0], hms[1], hms[2])
	}

	prototype.padStart = function(targetLen) {
		return targetLen > this.length ? new Array(targetLen - this.length + 1).join("0") + String(this) : String(this)
	}

	prototype.flUpperCase = function() {
		return this.charAt(0).toUpperCase() + this.slice(1)
	}

	prototype.repeat = function(num) {
		return new Array(num + 1).join(this)
	}

	prototype.trim = function() {
		return this.replace(/^\s+|\s+$/g, '')
	}

	prototype.toDelimited = function() {
		var result = this.split(".");
		result[0] = result[0].replace(/\B(?=(\d{3})+(?!\d))/g, " ");
		return result.join(",")
	}
}

with (Number) {
	prototype.toDelimited = function(precision) {
		var result = this.toFixed(precision).split(".");
		result[0] = result[0].replace(/\B(?=(\d{3})+(?!\d))/g, " ");
		return result.join(",")
	}
}

with (Array) {
	prototype.padZero = function() {
		for (var i = 0; i < this.length; i++) {
			if (this[i] < 10) this[i] = "0" + this[i];
		}		
	}
}
	/*prototype.includes = function(target) {
		var found = i = 0;
		while (!found && i < this.length) {
			found = this[i] == target;
			i++;
		}
		return found
	}
}*/
%>