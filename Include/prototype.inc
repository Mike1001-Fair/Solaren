<% //@ LANGUAGE = "JScript"
with (Date) {
	prototype.toStr = function(includeTime) {
		var ymd = [this.getFullYear(), this.getMonth() + 1, this.getDate()],
		result = [];
		ymd.padZero();
		result.push(ymd.join("-"));
		if (includeTime) {
			var hms = [this.getHours(), this.getMinutes(), this.getSeconds()];
 			hms.padZero();
			result.push(hms.join(":"));
		}
		return result.join('T')
	}
}

with (String) {
	prototype.formatDate = function(delimiter) {
		var dateParts = this.split(delimiter).reverse();
		return dateParts.join(delimiter == "." ? "-" : ".")
	}

	prototype.isDate = function () {
		return /^\d{4}-\d{2}-\d{2}(T\d{2}:\d{2}:\d{2})?$/.test(this)
	}

	prototype.toDate = function() {
		var dt  = this.split('T'),
		hasTime = dt.length == 2,
		ymd     = dt[0].split('-');
		if (hasTime) {
			var hms = dt[1].split(':');
		}
		return hasTime ? new Date(ymd[0], ymd[1]-1, ymd[2], hms[0], hms[1], hms[2]) : new Date(ymd[0], ymd[1] - 1, ymd[2])
	}

	prototype.padStart = function(targetLen, padChar) {
		return targetLen > this.length ? new Array(targetLen - this.length + 1).join(padChar) + String(this) : String(this)
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
			if (this[i] < 10) {
				this[i] = "0" + this[i];
			}
		}		
	}
}%>