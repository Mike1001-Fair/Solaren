<% //@ LANGUAGE = "JScript"
var CodePage = {
	List: {
		"65001": "utf-8",
		"1251": "windows-1251"
	},

	Write: function() {
		var ResponseText = ['<SELECT NAME="ReportCodePage">'],
		option;
		for (var k in this.List) {
			option = ['<OPTION VALUE="', k, '">', this.List[k], '</OPTION>'];
			ResponseText.push(option.join(""));
		}
		ResponseText.push('</SELECT>');
		Response.Write(ResponseText.join("\n"));
	}
}%>