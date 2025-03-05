<% //@ LANGUAGE = "JScript"
var Html = {
	Version: "v=4.6",
	Author : "Mykola Chernov",
	Title  : "Title",

	SetHead: function(Title, UseScripts) {
		this.Title = Title;
		var Head = [
			'<META charset="utf-8">',
			'<META NAME="author" CONTENT="' + this.Author + '">',
			'<META NAME="copyright" CONTENT="' + this.Author + '">',
			'<META NAME="viewport" CONTENT="width=device-width, initial-scale=1.0">',
			Tag.Write('TITLE', -1, Title),
			Icon.Link("sun.svg"),
			Styles.Write()
		];
		if (UseScripts) {
			Head.push(Scripts.Write());
		}
		var ResponseText = [
			'<!DOCTYPE html>',
			'<HTML LANG="en">',
			Tag.Write('HEAD', -1, Head.join("\n"))
		];				
		with (Response) {
			CacheControl = "no-cache, no-store;";
			AddHeader("X-Content-Type-Options", "nosniff");
			Charset = "utf-8";
			Write(ResponseText.join("\n"));
		}
	},

	WriteScript: function() {
		var ScriptName = Solaren.ScriptName.split("/").pop(),
		FileParts      = ScriptName.split('.'),
		FileName       = Scripts.Map(FileParts[0].toLowerCase()),
		ResponseText   = ['\n<SCRIPT DEFER SRC="', FileName, '"></SCRIPT>'];
		Response.Write(ResponseText.join(""));
	},

	SetPage: function(Title, RoleId) {
		this.SetHead(Title, 1);
		this.WriteScript();
		Menu.Write(RoleId, 0);
	},

	Write: function(tag, align) {
		var align = align ? ' ALIGN="' + align + '">' : '>',
		result = ['</', tag, '><', tag, align];
		return result.join("")
	},

	WriteRole: function(tagName, RoleId) {
		var ResponseText = ['<SELECT NAME="' + tagName + '">'],
		selected, option;
		for (var i = 0; i < User.Role.length; i++) {
			selected = i == RoleId ? '" SELECTED>' : '">';
			option = ['<OPTION VALUE="', i, selected, User.Role[i], '</OPTION>'];
			ResponseText.push(option.join(""));
		}
		ResponseText.push('</SELECT>');
		Response.Write(ResponseText.join("\n"))
	},
	
	WriteBaseInfo: function(rs) {
		var Header = ['Назва', 'Файл', 'Стан', 'Розмір'],
		ResponseText = ['<DIV CLASS="FormDiv">',
			'<FIELDSET CLASS="FieldSet">',
			'<LEGEND>Параметри</LEGEND>',
			'<TABLE CLASS="RulesAllInfo">',
			this.GetHeadRow(Header)
		];
		for (var row; !rs.EOF; rs.MoveNext()) {
			row = ['<TR>', Tag.Write("TD", 0, rs.Fields("BaseName")),
				Tag.Write("TD", 0, rs.Fields("FilesName")),
				Tag.Write("TD", -1, rs.Fields("FileState")),
				Tag.Write("TD", 2, rs.Fields("FileSize")), '</TR>'
			];
			ResponseText.push(row.join(""));
		} rs.Close();
		ResponseText.push('</TABLE></FIELDSET></DIV>');
		Response.Write(ResponseText.join("\n"))
	},

	WriteEditButton: function(AllowDelBtn) {
		var ResponseText = [];
		if (typeof Deleted != "undefined" && Deleted) {
			ResponseText.push('<BUTTON CLASS="RestoreBtn" ID="RestoreBtn">&#9851;Вiдновити</BUTTON>');
		} else {
			ResponseText.push('<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn">&#128190;Зберегти</BUTTON>');
			if (AllowDelBtn) {
				ResponseText.push('<BUTTON CLASS="DelBtn" ID="DelBtn">&#128465;Видалити</BUTTON>');
			}
		}
		Response.Write(ResponseText.join("\n"));
	},

	WriteDatePeriod: function(legend, begDate, endDate, minDate, maxDate) {
		var ResponseText = ['<FIELDSET>', '<LEGEND>' + legend + '</LEGEND>',
			'<INPUT TYPE="date" NAME="BegDate" VALUE="' + begDate +
			'" MIN="' + minDate + '" MAX="' + maxDate + '" REQUIRED> &#8722;',
			'<INPUT TYPE="date" NAME="EndDate" VALUE="' + endDate +
			'" MIN="' + minDate + '" MAX="' + maxDate + '" REQUIRED>',
			'</FIELDSET>\n'
		];
		Response.Write(ResponseText.join("\n"));
	},

	WriteMonthPeriod: function() {
		var OperMonth = Month.GetMonth(1),
		MinMonth = Month.GetMonth(0),
		ResponseText = ['<FIELDSET><LEGEND>Перioд</LEGEND>',
			'<INPUT TYPE="Month" NAME="BegMonth" VALUE="' + OperMonth +
			'" MIN="' + MinMonth + '" MAX="' + OperMonth + '" REQUIRED> &#8722;',
			'<INPUT TYPE="Month" NAME="EndMonth" VALUE="' + OperMonth +
			'" MIN="' + MinMonth  +	'" MAX="' + OperMonth +	'" REQUIRED>',
			'</FIELDSET>\n'
		];
		Response.Write(ResponseText.join("\n"));
	},

	WriteInputDataList : function(tagName, tagValue, tagSize, autoFocus) {
		var inputName = tagName + "Name",
		listName = tagName + "List",
		tagAttribute = autoFocus ? ' AUTOFOCUS>' : '>',
		ResponseText = ['<INPUT TYPE="search" NAME="' + inputName +
			'" ID="' + inputName + '" VALUE="' + tagValue +
			'" PLACEHOLDER="Пошук" SIZE="' + tagSize +
			'" LIST="' + listName + '" REQUIRED' + tagAttribute,
			'<DATALIST ID="' + listName + '"></DATALIST>'
		];
		Response.Write(ResponseText.join("\n"));
	},

	WriteSearchSet: function(title, tagName, tagValue, tagRequired) {
		var inputName = tagName + "Name",
		listName = tagName + "List",
		required = tagRequired ? " REQUIRED" : "",
		ResponseText = [
			'<FIELDSET><LEGEND>' + title + '</LEGEND>',
			'<INPUT TYPE="search" NAME="' + inputName + '" ID="' + inputName +
			'" VALUE="' + tagValue + '" PLACEHOLDER="Пошук" SIZE=35"' +
			'" LIST="' + listName + '"' + required + ' AUTOFOCUS>',
			'<DATALIST ID="' + listName + '"></DATALIST>',
			'</FIELDSET>'
		];
		Response.Write(ResponseText.join("\n"));
	},

	WriteSelect: function(rs, objName, blankOption, elementId) {
		var tagId = objName + "Id",
		tagName  = objName + "Name",
		ResponseText = ['<SELECT NAME="' + tagId + '" ID="' + tagId + '">'];
		if (blankOption) {
			ResponseText.push('<OPTION VALUE="0"></OPTION>');
		}
		for (var selected, option; !rs.EOF; rs.MoveNext()) {
			selected = elementId == rs.Fields(tagId) ? '" SELECTED>' : '">';
			option = ['<OPTION VALUE="', rs.Fields(tagId), selected, rs.Fields(tagName), '</OPTION>'];
			ResponseText.push(option.join(""));
		}
		rs.Close();
		ResponseText.push('</SELECT>');
		Response.Write(ResponseText.join("\n"));
	},

	WriteList: function(tagName, list) {
		var ResponseText = ['<SELECT NAME="' + tagName + '" ID="' + tagName + '">'];
		if (list && list instanceof Array && list.length > 0) {
			for (var i = 0; i < list.length; i++) {
				var option = ['<OPTION VALUE="', i, '">', list[i], '</OPTION>'];
				ResponseText.push(option.join(""));
			}
		} else {
			var option = ['<OPTION VALUE="', -1, '">', 'Invalid array', '</OPTION>'];
			ResponseText.push(option.join(""));
		}
		ResponseText.push('</SELECT>');
		Response.Write(ResponseText.join("\n"));
	},

	WriteBank: function(rs, MfoCode) {
		var ResponseText = ['<SELECT NAME="MfoCode" ID="MfoCode">'];
		for (var selected, option; !rs.EOF; rs.MoveNext()) {
			selected = MfoCode == rs.Fields("MfoCode") ? '" SELECTED>' : '">';
			option = ['<OPTION VALUE="', rs.Fields("MfoCode"), selected, rs.Fields("BankName"), '</OPTION>'];
			ResponseText.push(option.join(""));
		}
		rs.Close();
		ResponseText.push('</SELECT>');
		Response.Write(ResponseText.join("\n"));
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

	GetHeadRow: function(header) {
		var Row = ['<TR>'];
		if (header && header instanceof Array && header.length > 0) {
			for (var i = 0; i < header.length; i++) {
				Row.push('<TH>' + header[i] + '</TH>');
			}
		} else {
			Row.push('<TH>Invalid header array</TH>');
		}
		Row.push('</TR>');
		return Row.join("");
	},

	GetFooterRow: function(ColSpan, i) {
		var ResponseText = ['<TR><TH ALIGN="LEFT" COLSPAN="' + ColSpan + '">Всього: ' + i + '</TH></TR>',
			'</TABLE></BODY></HTML>'
		];
		return ResponseText.join("\n")
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

	WriteDate: function() {
		var ResponseText = ['<FIELDSET><LEGEND>Дата</LEGEND>',
			'<LABEL>З <INPUT TYPE="date" NAME="BegDate" VALUE="' + Month.Date[1] +
			'" MIN="' + Month.Date[0] + '" MAX="' + Month.Date[3] +	'" REQUIRED></LABEL>',
			'</FIELDSET>\n'
		];
		Response.Write(ResponseText.join("\n"));
	}	
},

Styles = {
	Path: "Styles/",
	Files: ["solaren", "body", "table", "loader", "button", "menu"],

	Write: function() {
		var Block = [];
		for (var i = 0; i < this.Files.length; i++) {
			var row = ['<LINK REL="stylesheet" HREF="', this.Path, this.Files[i], '.css?', Html.Version, '">'];
			Block.push(row.join(""));
		}
		return Block.join("\n");
	}
},

Scripts = {
	Path: "Scripts/",
	Files: ["lib", "loader", "user", "resource", "menu", "ajax"],

	Map: function(fileName) {
		var fullFileName = [this.Path, fileName, '.js?', Html.Version];
		return fullFileName.join("")
	},

	Write: function() {
		var Block = [];
		for (var i = 0; i < this.Files.length; i++) {
			var FileName = this.Map(this.Files[i]),
			row = ['<SCRIPT DEFER SRC="', FileName, '"></SCRIPT>'];
			Block.push(row.join(""));
		}
		return Block.join("\n");
	}
},

Icon = {
	Path: "Images/",

	Map: function(fileName) {
		var fullFileName = [this.Path, fileName];
		return fullFileName.join("");
	},

	Link: function(fileName) {
		var row = ['<LINK REL="shortcut icon" TYPE="image/svg+xml" HREF="', this.Map(fileName), '">'];
		return row.join("");
	}
},

Tag = {
	Align: ["LEFT", "CENTER", "RIGHT"],

	Write: function(tagName, index, tagValue) {
		var tagAttribute = this.Align[index] ? ' ALIGN="' + this.Align[index] + '">' : '>',
		result = ['<', tagName, tagAttribute, tagValue, '</', tagName, '>'];
		return result.join("")
	}
},

Menu = {
	Type: ["admin", "officeuser", "branchuser"],

	Write: function(RoleId, BodyTag) {
		var ScriptName = "menu-" + this.Type[RoleId] + ".asp";
		if (BodyTag) {
			Response.Write('\n<BODY CLASS="MainBody" ID="MainBody">');
			Server.Execute(ScriptName);
			Response.Write('</BODY></HTML>');
		} else {
			Server.Execute(ScriptName);
		}
	}
}%>