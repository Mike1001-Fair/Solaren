<% //@ LANGUAGE = "JScript"
var	CPList = {
	"65001": "utf-8",
	"1251": "windows-1251"
},

CodePage = {
	Write: function() {
		var ResponseText = ['<SELECT NAME="ReportCodePage">'];
		for (var k in CPList) {
			var option = ['<OPTION VALUE="', k, '">', CPList[k], '</OPTION>'];
			ResponseText.push(option.join(""));
		}
		ResponseText.push('</SELECT>');
		Response.Write(ResponseText.join("\n"));
	}
}%>