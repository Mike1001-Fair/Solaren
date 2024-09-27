<% //@ LANGUAGE="JScript"
var Uploader = {
	MaxSize: 5000000, // 5 MB

	Run: function() {
	    var Method      = Request.ServerVariables("REQUEST_METHOD"),
		ContentType = String(Request.ServerVariables("HTTP_Content_Type")),
		TotalBytes  = Request.TotalBytes,
		BinaryData  = Request.BinaryRead(TotalBytes);

		Response.Write("Method=" + Method + "<br>ContentType=" + ContentType + "<br>TotalBytes=" + TotalBytes);
		
		if (TotalBytes < this.MaxSize && Method == "POST") {
			var Boundary = ContentType.split("boundary=")[1],	// Получаем границу (boundary) из заголовка Content-Type			
			StringData = this.ToString(BinaryData),			// Конвертируем массив байт в строку
			parts = StringData.split("--" + Boundary);		// Разбиваем данные по границе

			Response.Write("<br>Boundary =" + Boundary + "<br>StringData=" + StringData + "<br>parts.length=" + parts.length);

			for (var i = 1; i < parts.length - 1; i++) {    // Проходим по каждой части
				Response.Write("<BR>parts[" + i + "]" + parts[i]);

				if (parts[i].indexOf("filename") > -1) {        // Обработка каждой части (возможно, это файл)
					var fileData = parts[i],
					bodyIndex = fileData.search(/\r\n\r\n|\n\n|\r\r/) + 4,  // находим конец заголовков, // Избавляемся от заголовков части, оставляя только тело файла
					//var bodyIndex = fileData.indexOf("\r\n\r\n") + 4;  // находим конец заголовков
					fileBody = fileData.substring(bodyIndex);

					Response.Write("<br>fileData=" + fileData + "<br>fileBody=" + fileBody);

					var fileNameMatch = /filename="(.+?)"/.exec(fileData),            // Извлекаем имя файла
					fileName = fileNameMatch ? fileNameMatch[1] : "unknown",
					filePath = Server.MapPath("Uploads/"+ fileName);
					//this.SaveStringAsBinaryFile(fileBody, filePath);
					BinaryData = this.ToBinary(fileBody);
					this.SaveFile(BinaryData, filePath);
				}
			}
		}
	},

	ToStringNew: function(Binary) {
		var cl1 = 1, cl2 = 1, cl3 = 1;
		var pl1 = '', pl2 = '', pl3 = '';
		var L = Request.TotalBytes;

		while (cl1 <= L) {
			pl3 += String.fromCharCode(Binary.charCodeAt(cl1 - 1));
			cl1++;
			cl3++;
			if (cl3 > 300) {
				pl2 += pl3;
				pl3 = '';
				cl3 = 1;
				cl2++;
				if (cl2 > 200) {
					pl1 += pl2;
					pl2 = '';
					cl2 = 1;
				}
			}
		}
		return pl1 + pl2 + pl3;
	},

	ToString: function(BinaryData) {
		//Response.Write("Run BinaryToString<br>");
		var stream = Server.CreateObject("ADODB.Stream");
		with (stream) {
			Type = 1;	// adTypeBinary
			Open();
			Write(BinaryData);
			Position = 0;
			Type = 2;	// adTypeText
			Charset = "UTF-8";	// Используйте соответствующую кодировку
		}
		var stringValue = stream.ReadText();
		stream.Close();
		//Response.Write("Done BinaryToString<br>");
		return stringValue;
	},

	ToBinary: function(StringData) {
		var stream = Server.CreateObject("ADODB.Stream"),
		BinaryData;
		with (stream) {
			Type = 2;  // adTypeText
			Charset = "UTF-8";  // Используйте соответствующую кодировку
			Open();
			WriteText(StringData);
			Position = 0;
			Type = 1;  // adTypeBinary
			BinaryData = Read();
			Close();
		}
		return BinaryData;
	},

	SaveFile: function(binaryData, filePath) {
		var stream = Server.CreateObject("ADODB.Stream");
		with (stream) {
			Type = 1;
			Open();
			Write(binaryData);
			Position = 0;
			SaveToFile(filePath, 2);
			Close();
		}
	}
},

FileData = {
    // Приватные переменные
    m_fileName: '',
    m_contentType: '',
    m_BinaryContents: '',
    m_AsciiContents: '',
    m_imageWidth: -1,
    m_imageHeight: -1,
    m_checkImage: false,

    // Геттеры и сеттеры для свойств объекта
    get_FormFieldName: function () {
        return this.m_formFieldName;
    },

    set_FormFieldName: function (sFieldName) {
        this.m_formFieldName = sFieldName;
    },

    get_ContentDisposition: function () {
        return this.m_contentDisposition;
    },

    set_ContentDisposition: function (sContentDisposition) {
        this.m_contentDisposition = sContentDisposition;
    },

    get_FileName: function () {
        return this.m_fileName;
    },

    get_ContentType: function () {
        return this.m_contentType;
    },

    get_ImageWidth: function () {
        if (!this.m_checkImage) {
            this.checkImageDimensions();
        }
        return this.m_imageWidth;
    },

    get_ImageHeight: function () {
        if (!this.m_checkImage) {
            this.checkImageDimensions();
        }
        return this.m_imageHeight;
    },

    set_FileName: function (strName) {
        strName = strName.replace("/", "\\");
        this.m_fileName = strName;
    },

    set_CheckImage: function (blnCheck) {
        this.m_checkImage = blnCheck;
    },

    set_ContentType: function (strType) {
        this.m_contentType = strType;
    },

    set_Contents: function (strData) {
        this.m_BinaryContents = strData;
        this.m_AsciiContents = this.RSBinaryToString(this.m_BinaryContents);
    },

    get_Size: function () {
        return LenB(this.m_BinaryContents);
    },

    // Приватные методы объекта
    checkImageDimensions: function () {
        var width, height, colors, strType;

        if (this.gfxSpex(this.m_AsciiContents, width, height, colors, strType)) {
            this.m_imageWidth = width;
            this.m_imageHeight = height;
        }

        this.m_checkImage = true;
    },

    RSBinaryToString: function (xBinary) {
        // Метод для конвертации бинарных данных в строку
        // ... ваш код конвертации ...
    },

    gfxSpex: function (flnm, width, height, depth, strImageType) {
        // Метод для определения характеристик графического файла
        // ... ваш код определения ...
    }
};
%>