<% //@ LANGUAGE = "JScript"
var CodePage = {
	65001: "utf-8",
	1251 : "windows-1251",

	Write: function() {
		var ResponseText = ['<SELECT NAME="ReportCodePage">'],
		option;
		for (var k in this) {
			if (this.hasOwnProperty(k) && !isNaN(k)) {
				option = ['<OPTION VALUE="', k, '">', this[k], '</OPTION>'];
				ResponseText.push(option.join(""));
			}
		}
		ResponseText.push('</SELECT>');
		Response.Write(ResponseText.join("\n"));
	}
}%>