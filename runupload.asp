<!-- #INCLUDE FILE="Include/upload.inc" -->
<%
Dim objUpload
Set objUpload = New UploadHelper
If objUpload.GetError <> "" Then
	Response.Write("Warning: "&objUpload.GetError)
Else  
	'Response.Write("found "&objUpload.FileCount&" files...<br />")
	Dim x
	For x = 0 To objUpload.FileCount - 2
		'Response.Write("file name: "&objUpload.File(x).FileName&"<br />" &_
		'"file type: "&objUpload.File(x).ContentType&"<br />" &_
		'"file size: "&objUpload.File(x).Size&"<br />" &_
		'"Saved at: E:\AspApp\Db\Uploads<br />")

		'If want to convert the virtual path to physical path then use MapPath
		Call objUpload.File(x).SaveToDisk("E:\AspApp\Db\Uploads", "")
		'Response.Write("file saved successfully!<hr />")
	Next 
	Server.Transfer("done.asp")
End If
%>
