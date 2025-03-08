<!-- #INCLUDE FILE="Include/uploader.inc" -->
<%

Set Upload = New FreeASPUpload

' Папка, куда сохраняем файлы
Dim SaveToFolder
SaveToFolder = Server.MapPath("/uploads/")

' Сохраняем файлы (путь передаём в метод Save, а не через свойство)
Upload.Save SaveToFolder

' Получаем имя загруженного файла
FileName = Upload("file1").FileName

' Выводим имя файла
Response.Write "Файл загружен: " & Server.HTMLEncode(FileName)

' Освобождаем объект
Set Upload = Nothing
%>