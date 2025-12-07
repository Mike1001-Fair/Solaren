<% //@ LANGUAGE = "JScript"
var	CpList = {
	"65001": "utf-8",
	"1251": "windows-1251"
},

CodePage = {
	Write: function() {
		var Output = ['<SELECT NAME="ReportCodePage">'];
		for (var k in CpList) {
			var option = Html.GetOption(k, 0, CpList[k]);
			Output.push(option);
		}
		Output.push('</SELECT>');
		Response.Write(Output.join("\n"));
	}
}%>