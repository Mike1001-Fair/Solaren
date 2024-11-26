<% //@ LANGUAGE = "JScript"
var CodePage = {
	65001: "utf-8",
	1251 : "windows-1251"
},

Html = {
	Version     : "v=3.2",
	Path        : ["Scripts/", "Styles/", "Images/"],
	Date        : ["2015-01-01", String(Session("OperDate")), String(Session("EndDate")), String(Session("NextDate")), "9999-12-31"],
	LocalityType: ["місто","селище","село","смт"],
	StreetType  : ["вулиця","проспект","бульвар","провулок","площа","тупік","шоссе","проїзд"],
	TarifGroup  : ["Сонце до 30 кВт", "Сонце до 50 кВт", "Комбінована до 50 кВт"],
	Author      : "Mykola Chernov",

	GetMonth: function(index) {
		return this.Date[index].slice(0, 7)
	},

	GetImage: function(fileName) {
		var fullFileName = [this.Path[2], fileName];
		return fullFileName.join("");
	},

	WriteStyleBlock: function() {
		var Sheets = ["solaren", "body", "table", "loader", "button", "menu"],
		StyleBlock = "",
		StyleRow;
		for (var i = 0; i < Sheets.length; i++) {
			StyleRow = ['<LINK REL="stylesheet" HREF="', this.Path[1], Sheets[i], '.css?', this.Version, '">\n'];
			StyleBlock += StyleRow.join("");
		}
		return StyleBlock
	},

	WriteScriptBlock: function() {
		var Scripts = ["lib", "loader", "user", "resource", "menu", "ajax"],
		ScriptBlock = "",
		ScriptRow;
		for (var i = 0; i < Scripts.length; i++) {
			ScriptRow = ['<SCRIPT DEFER SRC="', this.Path[0], Scripts[i], '.js?', this.Version, '"></SCRIPT>\n'];
			ScriptBlock += ScriptRow.join("");
		}
		return ScriptBlock
	},

	SetHead: function(TitleText) {
		with (Response) {
			CacheControl = "no-cache, no-store;";
			AddHeader("X-Content-Type-Options", "nosniff");
			//Expires = -9;
			Charset = "utf-8";
			Write('<!DOCTYPE html>\n' +
			'<HTML LANG="en">\n' +
			'<HEAD>\n' + 
			'<META charset="utf-8">\n' +
			'<META NAME="author" CONTENT="' + this.Author + '">\n' +
			'<META NAME="copyright" CONTENT="' + this.Author + '">\n' +
			'<META NAME="viewport" CONTENT="width=device-width, initial-scale=1.0">\n' +
			//'<META HTTP-EQUIV="Content-Security-Policy" CONTENT="default-src \'self\'; SCRIPT-SRC \'self\'">\n' +
			'<TITLE>' + TitleText + '</TITLE>\n' +
			'<LINK REL="shortcut icon" TYPE="image/svg+xml" HREF="' + this.GetImage("sun.svg") + '">\n' +
			this.WriteStyleBlock() +
			this.WriteScriptBlock() + '</HEAD>\n');
		}
	},

	WriteScript: function() {
		var ScriptArr  = Solaren.ScriptName.split("/"),
		FileArr        = ScriptArr[ScriptArr.length - 1].split('.'),
		FileName       = [this.Path[0], FileArr[0].toLowerCase(), ".js?", this.Version],
		ResponseText   = ['<SCRIPT DEFER SRC="', FileName.join(""), '"></SCRIPT>'];
		Response.Write(ResponseText.join(""));
	},

	WriteMenu: function(RoleId, BodyTag) {
		var RoleName = ["admin", "officeuser", "branchuser"],
		ScriptName = "menu-" + RoleName[RoleId] + ".asp";
		if (BodyTag) {
			Response.Write('<BODY CLASS="MainBody" ID="MainBody">');
			Server.Execute(ScriptName);
			Response.Write('</BODY></HTML>');
		} else {
			Server.Execute(ScriptName);
		}
	},

	SetPage: function(Title, RoleId) {
		this.SetHead(Title);
		this.WriteScript();
		this.WriteMenu(RoleId, 0);
	},

	Write: function(tag, align) {
		var align = align ? ' ALIGN="' + align + '">' : '>',
		result = ['</', tag, '><', tag, align];
		return result.join("")
	},

	WriteTarif: function(tagName, GroupId) {
		var ResponseText = '<SELECT NAME="' + tagName + '">',
		selected, option;
		for (var i = 0; i < this.TarifGroup.length; i++) {
			selected = i == GroupId ? '" SELECTED>' : '">';
			option = ['<OPTION VALUE="', i, selected, this.TarifGroup[i], '</OPTION>'];
			ResponseText += option.join("");
		}
		ResponseText += '</SELECT>';
		Response.Write(ResponseText)
	},

	WriteTarifGroup: function() {
		var ResponseText = ['<FIELDSET>\n<LEGEND>Група</LEGEND>\n<SELECT NAME="GroupId">'];
		for (var i = 0; i < this.TarifGroup.length; i++) {
			ResponseText.push('<OPTION VALUE="' + i + '">' + this.TarifGroup[i] + '</OPTION>');
		}
		ResponseText.push('</SELECT>\n</FIELDSET>\n');
		Response.Write(ResponseText.join(""));
	},

	WriteStreetType: function(tagName, StreetType) {
		var ResponseText = '<SELECT NAME="' + tagName + '">',
		selected, option;
		for (var i = 0; i < this.StreetType.length; i++) {
			selected = i == StreetType ? '" SELECTED>' : '">';
			option = ['<OPTION VALUE="', i, selected, this.StreetType[i], '</OPTION>'];
			ResponseText += option.join("");
		}
		ResponseText += '</SELECT>';
		Response.Write(ResponseText)
	},

	WriteLocalityType: function(tagName, LocalityType) {
		var ResponseText = '<SELECT NAME="' + tagName + '" ID="' + tagName + '">',
		itemNodes = new Enumerator(XmlDoc.selectNodes("//LocalityType")),
		itemId,
		option,
		selected;
		for (var node; !itemNodes.atEnd(); itemNodes.moveNext()) {
			node = itemNodes.item();
			itemId = node.getAttribute("id");
			selected = itemId == LocalityType ? '" SELECTED>' : '">';
			option = ['<OPTION VALUE="', itemId, selected, node.text, '</OPTION>'];
			ResponseText += option.join("");
		}
		ResponseText += '</SELECT>';
		Response.Write(ResponseText);
	},

	/*WriteLocalityType: function(tagName, LocalityType) {
		var ResponseText = '<SELECT NAME="' + tagName + '" ID="' + tagName + '">',
		selected, option;
		for (var k in this.LocalityType) {
			selected = k == LocalityType ? '" SELECTED>' : '">';
			option = ['<OPTION VALUE="', k, selected, this.LocalityType[k], '</OPTION>'];
			ResponseText += option.join("");
		}
		Response.Write(ResponseText + '</SELECT>')
	},*/

	WriteRole: function(tagName, RoleId) {
		var ResponseText = '<SELECT NAME="' + tagName + '">',
		selected, option;
			for (var i = 0; i < User.Role.length; i++) {
			selected = i == RoleId ? '" SELECTED>' : '">';
			option = ['<OPTION VALUE="', i, selected, User.Role[i], '</OPTION>'];
			ResponseText += option.join("");
		}
		Response.Write(ResponseText + '</SELECT>')
	},
	
	WriteBaseInfo: function(rs) {
		var ResponseText = '<DIV CLASS="FormDiv">\n<FIELDSET CLASS="FieldSet">\n<LEGEND>Параметри</LEGEND>\n<TABLE CLASS="RulesAllInfo">\n' +
		'<TR><TH>Назва</TH><TH>Файл</TH><TH>Стан</TH><TH>Розмір</TH></TR>\n';
		for (; !rs.EOF; rs.MoveNext()) {
			ResponseText += '<TR><TD ALIGN="LEFT">' + rs.Fields("BaseName") +
			this.Write("TD","LEFT") + rs.Fields("FilesName") +
			this.Write("TD","") + rs.Fields("FileState") +
			this.Write("TD","RIGHT") + rs.Fields("FileSize") + '</TD></TR>\n';
		} rs.Close();
		ResponseText += '</TABLE></FIELDSET></DIV>';
		Response.Write(ResponseText)
	},

	WriteEditButton: function(AllowDelBtn) {
		var ResponseText = '<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn">&#128190;Зберегти</BUTTON>\n';
		if (typeof Deleted != "undefined" && Deleted) {
			ResponseText = '<BUTTON CLASS="RestoreBtn" ID="RestoreBtn">&#9851;Вiдновити</BUTTON>';
		} else if (AllowDelBtn) {
			ResponseText += '<BUTTON CLASS="DelBtn" ID="DelBtn">&#128465;Видалити</BUTTON>';
		}
		Response.Write(ResponseText);
	},

	WriteDatePeriod: function(legend, begDate, endDate, minDate, maxDate) {
		var ResponseText = ['<FIELDSET><LEGEND>', legend, '</LEGEND>\n',
			'<INPUT TYPE="date" NAME="BegDate" VALUE="' + begDate,
			'" MIN="' + minDate,
			'" MAX="' + maxDate,
			'" REQUIRED> &#8722;\n',
			'<INPUT TYPE="date" NAME="EndDate" VALUE="' + endDate,
			'" MIN="' + minDate,
			'" MAX="' + maxDate,
			'" REQUIRED>\n</FIELDSET>\n'];
		Response.Write(ResponseText.join(""));
	},

	WriteMonthPeriod: function() {
		var OperMonth = this.GetMonth(1),
		MinMonth = this.GetMonth(0),
		ResponseText = ['<FIELDSET><LEGEND>Перioд</LEGEND>\n',
			'<INPUT TYPE="Month" NAME="BegMonth" VALUE="' + OperMonth,
			'" MIN="' + MinMonth,
			'" MAX="' + OperMonth,
			'" REQUIRED> &#8722;\n',
			'<INPUT TYPE="Month" NAME="EndMonth" VALUE="' + OperMonth,
			'" MIN="' + MinMonth,
			'" MAX="' + OperMonth,
			'" REQUIRED>\n</FIELDSET>\n'
		];
		Response.Write(ResponseText.join(""));
	},

	WriteInputDataList : function(tagName, tagValue, tagSize) {
		var inputName = tagName + "Name",
		listName = tagName + "List",
		ResponseText = ['<INPUT TYPE="search" NAME="' + inputName,
			'" ID="' + inputName,
			'" VALUE="' + tagValue,
			'" PLACEHOLDER="Пошук по літерам" SIZE="' + tagSize,
			'" LIST="' + listName,
			'" REQUIRED>\n',
			'<DATALIST ID="' + listName + '"></DATALIST>'
		];
		Response.Write(ResponseText.join(""));
	},

	WriteSearchSet: function(title, tagName, tagValue, tagRequired) {
		var inputName = tagName + "Name",
		listName = tagName + "List",
		required = tagRequired ? " REQUIRED" : "",
		ResponseText = [
			'<FIELDSET><LEGEND>' + title + '</LEGEND>\n',
			'<INPUT TYPE="search" NAME="' + inputName,
			'" ID="' + inputName,
			'" VALUE="' + tagValue,
			'" PLACEHOLDER="Пошук по літерам" SIZE=35"',
			'" LIST="' + listName + '"',
			required + ' AUTOFOCUS>\n',
			'<DATALIST ID="' + listName + '"></DATALIST>\n</FIELDSET>'
		];
		Response.Write(ResponseText.join(""));
	},

	WriteSelect: function(rs, objName, blankOption, elementId) {
		var tagId = objName + "Id",
		tagName  = objName + "Name",
		ResponseText = '<SELECT NAME="' + tagId + '" ID="' + tagId + '">\n';
		if (blankOption) ResponseText += '<OPTION VALUE="0"></OPTION>';
		for (var selected, option; !rs.EOF; rs.MoveNext()) {
			selected = elementId == rs.Fields(tagId) ? '" SELECTED>' : '">';
			option = ['<OPTION VALUE="', rs.Fields(tagId), selected, rs.Fields(tagName), '</OPTION>'];
			ResponseText += option.join("");
		}
		rs.Close();
		ResponseText += '</SELECT>';
		Response.Write(ResponseText);
	},

	WriteBank: function(rs, MfoCode) {
		var ResponseText = '<SELECT NAME="MfoCode" ID="MfoCode">\n';
		for (var selected, option; !rs.EOF; rs.MoveNext()) {
			selected = MfoCode == rs.Fields("MfoCode") ? '" SELECTED>' : '">';
			option = ['<OPTION VALUE="', rs.Fields("MfoCode"), selected, rs.Fields("BankName"), '</OPTION>'];
			ResponseText += option.join("")
		}
		rs.Close();
		ResponseText += '</SELECT>';
		Response.Write(ResponseText);
	},

	WriteChiefDoc: function(rs, DocId) {
		var ResponseText = '<SELECT NAME="ChiefDocId" ID="ChiefDocId">\n';
		for (var selected, option; !rs.EOF; rs.MoveNext()) {
			selected = DocId == rs.Fields("DocId") ? '" SELECTED>' : '">';
			option = ['<OPTION VALUE="', rs.Fields("DocId"), selected, rs.Fields("DocName"), '</OPTION>'];
			ResponseText += option.join("");
		}
		rs.Close();
		ResponseText += '</SELECT>';
		Response.Write(ResponseText);
	},

	WriteChiefTitle: function(rs, TitleId) {
		var ResponseText = '<SELECT NAME="ChiefTitleId" ID="ChiefTitleId">\n';
		for (var selected, option; !rs.EOF; rs.MoveNext()) {
			selected = TitleId == rs.Fields("TitleId") ? '" SELECTED>' : '">';
			option = ['<OPTION VALUE="', rs.Fields("TitleId"), selected, rs.Fields("Title1"), '</OPTION>'];
			ResponseText += option.join("");
		}
		rs.Close();
		ResponseText += '</SELECT>';
		Response.Write(ResponseText);
	},

	GetFooterRow: function(ColSpan, i) {
		var ResponseText = ['<TR><TH ALIGN="LEFT" COLSPAN="', ColSpan, '">Всього: ', i, '</TH></TR>\n</TABLE></BODY></HTML>'];
		return ResponseText.join("")
	},

	WriteFileList: function(FolderName) {
		//var Fso = Server.CreateObject("Scripting.FileSystemObject"),
		var FolderPath = Server.MapPath(FolderName),
		ResponseText = '<SELECT NAME="FileSet" ID="FileSet" STYLE="width: 20em">\n';
		if (Fso.FolderExists(FolderPath)) {
			var Folder = Fso.GetFolder(FolderPath),
			Files = new Enumerator(Folder.Files);
			if (Folder.Files.Count > 0) {
				for (var fileName, option; !Files.atEnd(); Files.moveNext()) {
					fileName = Files.item().Name;
					option = ['<OPTION VALUE="', fileName, '">', fileName, '</OPTION>'];
					ResponseText += option.join("");
				}
			} else {
				ResponseText += '<OPTION>Folder is empty</OPTION>';
			}
		} else {
			ResponseText += '<OPTION>Folder not exists</OPTION>';
		}
		Response.Write(ResponseText + '</SELECT>');
	},

	WriteCodePage: function() {
		var ResponseText = '<SELECT NAME="ReportCodePage">',
		option;
		for (var k in CodePage) {
			option = ['<OPTION VALUE="', k, '">', CodePage[k], '</OPTION>'];
			ResponseText += option.join("");
		}
		ResponseText += '</SELECT>';
		Response.Write(ResponseText);
	},

	WriteDate: function() {
		var ResponseText = ['<FIELDSET>\n<LEGEND>Дата</LEGEND>\n',
			'<LABEL>З <INPUT TYPE="date" NAME="BegDate" VALUE="' + this.Date[1],
			'" MIN="' + this.Date[0],
			'" MAX="' + this.Date[3],
			'" REQUIRED></LABEL>\n</FIELDSET>\n'
		];
		Response.Write(ResponseText.join(""));
	}	
}%>