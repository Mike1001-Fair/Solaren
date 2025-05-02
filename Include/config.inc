<% //@ LANGUAGE = "JScript"
var Config = {
	Write: function(List) {
		if (Solaren.ValidObject(List)) {
			var ResponseText = ['<FIELDSET NAME="SysCfgSet"><LEGEND>Додаткові</LEGEND>'];
			for (var k in List) {
				var row = ['<LABEL CLASS="BlockLabel"><INPUT TYPE="CheckBox" NAME="', k, '">', List[k], '</LABEL>'];
				ResponseText.push(row.join(""));
			}
			ResponseText.push('</FIELDSET>');
			Response.Write(ResponseText.join("\n"));	
		} else {
			Message.Write(3, "Invalid object: List")
		}
	},

	DbInfo: function(rs) {
		var Header = ['Назва', 'Файл', 'Стан', 'Розмір'],
		ResponseText = ['<DIV CLASS="FormDiv">',
			'<FIELDSET CLASS="FieldSet">',
			'<LEGEND>Параметри</LEGEND>',
			'<TABLE CLASS="RulesAllInfo">',
			Html.GetHeadRow(Header)
		];
		for (; !rs.EOF; rs.MoveNext()) {
			var td = [Tag.Write("TD", 0, rs.Fields("BaseName")),
				Tag.Write("TD", 0, rs.Fields("FilesName")),
				Tag.Write("TD", -1, rs.Fields("FileState")),
				Tag.Write("TD", 2, rs.Fields("FileSize")),
			],
			tr = Tag.Write("TR", -1, td.join(""));
			ResponseText.push(tr);
		} rs.Close();
		ResponseText.push('</TABLE></FIELDSET></DIV>');
		Response.Write(ResponseText.join("\n"))
	}
}%>