<% //@ LANGUAGE = "JScript"
var	CpList = {
	"65001": "utf-8",
	"1251": "windows-1251"
},

CodePage = {
	Write: function() {
		var Output = ['<SELECT NAME="ReportCodePage">'];
		for (var k in CpList) {
			var option = ['<OPTION VALUE="', k, '">', CpList[k], '</OPTION>'];
			Output.push(option.join(""));
		}
		Output.push('</SELECT>');
		Response.Write(Output.join("\n"));
	}
}%>