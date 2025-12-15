<% //@ LANGUAGE = "JScript"
var Html = {
	Version: "v=2.25",

	SetHead: function(Title, UseScripts) {
		this.Title = Title || "Title";
		var Author = "Mykola Chernov",
		Head = [
			'<META charset="utf-8">',
			'<META NAME="author" CONTENT="' + Author + '">',
			'<META NAME="copyright" CONTENT="' + Author + '">',
			'<META NAME="viewport" CONTENT="width=device-width, initial-scale=1.0">',
			Tag.Write('TITLE', -1, this.Title),
			Icon.Write("sun.svg"),
			Styles.Write()
		];
		if (UseScripts) {
			Head.push(Scripts.Write());
		}
		var Output = [
			'<!DOCTYPE html>',
			'<HTML LANG="en">',
			Tag.Write('HEAD', -1, Head.join("\n"))
		];				
		with (Response) {
			CacheControl = "no-cache, no-store;";
			AddHeader("X-Content-Type-Options", "nosniff");
			Charset = "utf-8";
			Write(Output.join("\n"));
		}
	},

	WriteScript: function() {
		var ScriptName = Solaren.ScriptName.split("/").pop(),
		FileParts      = ScriptName.split('.'),
		FileName       = Scripts.Map(FileParts[0].toLowerCase()),
		Output         = ['\n<SCRIPT DEFER SRC="', FileName, '"></SCRIPT>'];
		Response.Write(Output.join(""));
	},

	SetPage: function(Title) {
		this.SetHead(Title, 1);
		this.WriteScript();
		Menu.Write(0);
	},

	GetLink: function (url, id, value) {
		var Output = ['<A href="', url, id, '">', Server.HTMLEncode(value), '</A>'];
		return Output.join("")
	},

	GetOption: function(value, selected, text) {
		var Selected = selected ? '" SELECTED>' : '">';
		option = ['<OPTION VALUE="', Server.HTMLEncode(value), Selected, text, '</OPTION>'];
		return option.join("")
	},
	
	WriteEditButton: function(AllowDelBtn, Deleted) {
		var Output = [];
		if (Deleted) {
			Output.push('<BUTTON CLASS="RestoreBtn" ID="RestoreBtn">&#9851;Вiдновити</BUTTON>');
		} else {
			Output.push('<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn">&#128190;Зберегти</BUTTON>');
			if (AllowDelBtn) {
				Output.push('<BUTTON CLASS="DelBtn" ID="DelBtn">&#128465;Видалити</BUTTON>');
			}
		}
		Response.Write(Output.join("\n"));
	},

	WriteInputDataList : function(tagName, tagValue, tagSize, autoFocus) {
		var inputName = tagName + "Name",
		listName = tagName + "List",
		tagAttribute = autoFocus ? ' AUTOFOCUS>' : '>',
		Output = ['<INPUT TYPE="search" NAME="' + inputName +
			'" ID="' + inputName + '" VALUE="' + tagValue +
			'" PLACEHOLDER="Пошук" SIZE="' + tagSize +
			'" LIST="' + listName + '" REQUIRED' + tagAttribute,
			'<DATALIST ID="' + listName + '"></DATALIST>'
		];
		Response.Write(Output.join("\n"));
	},

	WriteSearchSet: function(title, tagName, tagValue, tagRequired) {
		var inputName = tagName + "Name",
		listName = tagName + "List",
		required = tagRequired ? " REQUIRED" : "",
		Output = [
			'<FIELDSET><LEGEND>' + title + '</LEGEND>',
			'<INPUT TYPE="search" NAME="' + inputName + '" ID="' + inputName +
			'" VALUE="' + tagValue + '" PLACEHOLDER="Пошук" SIZE=35"' +
			'" LIST="' + listName + '"' + required + ' AUTOFOCUS>',
			'<DATALIST ID="' + listName + '"></DATALIST>',
			'</FIELDSET>'
		];
		Response.Write(Output.join("\n"));
	},

	WriteSelect: function(rs, objName, blankOption, elementId) {
		var tagId = objName + "Id",
		tagName  = objName + "Name",
		Output = ['<SELECT NAME="' + tagId + '" ID="' + tagId + '">'];
		if (blankOption) {
			Output.push('<OPTION VALUE="0"></OPTION>');
		}
		for (; !rs.EOF; rs.MoveNext()) {
			var selected = elementId == rs.Fields(tagId),
			option = this.GetOption(rs.Fields(tagId), selected, rs.Fields(tagName));
			Output.push(option);
		}
		rs.Close();
		Output.push('</SELECT>');
		Response.Write(Output.join("\n"));
	},

	WriteList: function(tagName, list) {
		if (list instanceof Array) {
			var Output = ['<SELECT NAME="' + tagName + '" ID="' + tagName + '">'];
			for (var i = 0; i < list.length; i++) {
				var option = this.GetOption(i, 0, list[i]);
				Output.push(option);
			}
			Output.push('</SELECT>');
			Response.Write(Output.join("\n"));
		} else {
			Message.Write(3, 'Invalid input array');
		}
	},

	WriteBank: function(rs, MfoCode) {
		var Output = ['<SELECT NAME="MfoCode" ID="MfoCode">'];
		for (; !rs.EOF; rs.MoveNext()) {
			var selected = MfoCode == rs.Fields("MfoCode"),
			option = this.GetOption(rs.Fields("MfoCode"), selected, rs.Fields("BankName"));
			Output.push(option);
		}
		rs.Close();
		Output.push('</SELECT>');
		Response.Write(Output.join("\n"));
	},

	WriteChiefDoc: function(rs, DocId) {
		var Output = ['<SELECT NAME="ChiefDocId" ID="ChiefDocId">'];
		for (; !rs.EOF; rs.MoveNext()) {
			var selected = DocId == rs.Fields("DocId"),
			option = this.GetOption(rs.Fields("DocId"), selected, rs.Fields("DocName"));
			Output.push(option);
		}
		rs.Close();
		Output.push('</SELECT>');
		Response.Write(Output.join("\n"));
	},

	WriteChiefTitle: function(rs, TitleId) {
		var Output = ['<SELECT NAME="ChiefTitleId" ID="ChiefTitleId">'];
		for (var selected, option; !rs.EOF; rs.MoveNext()) {
			var selected = TitleId == rs.Fields("TitleId"),
			option = this.GetOption(rs.Fields("TitleId"), selected, rs.Fields("Title1"));
			Output.push(option);
		}
		rs.Close();
		Output.push('</SELECT>');
		Response.Write(Output.join("\n"));
	},

	GetHeadRow: function(header) {
		var row = [];
		if (header instanceof Array) {
			for (var i = 0; i < header.length; i++) {
				var th = Tag.Write('TH', -1, header[i])
				row.push(th);
			}
		} else {
			var th = Tag.Write('TH', -1, 'Invalid input array')
			row.push(th);
		}
		var tr = Tag.Write('TR', -1, row.join(""))
		return tr
	},

	GetFooterRow: function(ColSpan, i) {
		var Output = ['<TR><TH ALIGN="LEFT" COLSPAN="' + ColSpan + '">Всього: ' + i + '</TH></TR>',
			'</TABLE></BODY></HTML>'
		];
		return Output.join("\n")
	},

	WriteFileList: function(FolderName) {
		//var Fso = Server.CreateObject("Scripting.FileSystemObject"),
		var FolderPath = Server.MapPath(FolderName);
		if (Fso.FolderExists(FolderPath)) {
			var Folder = Fso.GetFolder(FolderPath),
			Files = new Enumerator(Folder.Files);
			if (Folder.Files.Count > 0) {
				var Output = ['<SELECT NAME="FileSet" ID="FileSet" STYLE="width: 20em">'];				
				for (; !Files.atEnd(); Files.moveNext()) {
					var fileName = Files.item().Name,
					option = this.GetOption(fileName, 0, fileName);
					Output.push(option);
				}
				Output.push('</SELECT>');
				Response.Write(Output.join("\n"));
			} else {
				Message.Write(3, 'Folder is empty');
			}
		} else {
			Message.Write(3, 'Folder not exists');
		}
	}
},

Styles = {
	Map: function(fileName) {
		var Path = "Styles/",
		fullName = [Path, fileName, '.css?', Html.Version];
		return fullName.join("")
	},

	Write: function() {
		var Files = ["solaren", "body", "table", "loader", "button", "menu", "notify"],
		Block = [];
		for (var i = 0; i < Files.length; i++) {
			var FileName = this.Map(Files[i]),
			row = ['<LINK REL="stylesheet" HREF="', FileName, '">'];
			Block.push(row.join(""));
		}
		return Block.join("\n");
	}
},

Scripts = {
	Map: function(fileName) {
		var Path = "Scripts/",
		fullName = [Path, fileName, '.js?', Html.Version];
		return fullName.join("")
	},

	Write: function() {
		var Files = ["lib", "loader", "user", "resource", "notify", "menu", "redirect", "ajax"],
		Block = [];
		for (var i = 0; i < Files.length; i++) {
			var FileName = this.Map(Files[i]),
			row = ['<SCRIPT DEFER SRC="', FileName, '"></SCRIPT>'];
			Block.push(row.join(""));
		}
		return Block.join("\n");
	}
},

Icon = {
	Map: function(fileName) {
		var Path = "Images/",
		fullName = [Path, fileName];
		return fullName.join("")
	},

	Write: function(fileName) {
		var row = ['<LINK REL="shortcut icon" TYPE="image/svg+xml" HREF="', this.Map(fileName), '">'];
		return row.join("");
	}
},

Tag = {
	Write: function(tagName, index, tagValue) {
		var Align = ["LEFT", "CENTER", "RIGHT"],
		tagAttribute = Align[index] ? ' ALIGN="' + Align[index] + '">' : '>',
		result = ['<', tagName, tagAttribute, tagValue, '</', tagName, '>'];
		return result.join("")
	}
}%>