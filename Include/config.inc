<% //@ LANGUAGE = "JScript"
var Config = {
	Write: function(List) {
		var ResponseText = ['<FIELDSET NAME="SysCfgSet"><LEGEND>Додаткові</LEGEND>'];
		for (var k in List) {
			var row = ['<LABEL CLASS="BlockLabel"><INPUT TYPE="CheckBox" NAME="', k, '">', List[k], '</LABEL>'];
			ResponseText.push(row.join(""));
		}
		ResponseText.push('</FIELDSET>');
		Response.Write(ResponseText.join("\n"));	
	}
}%>