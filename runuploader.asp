<!-- #INCLUDE FILE="Include/uploader.inc" -->
<%

Set Upload = New FreeASPUpload

' �����, ���� ��������� �����
Dim SaveToFolder
SaveToFolder = Server.MapPath("/uploads/")

' ��������� ����� (���� ������� � ����� Save, � �� ����� ��������)
Upload.Save SaveToFolder

' �������� ��� ������������ �����
FileName = Upload("file1").FileName

' ������� ��� �����
Response.Write "���� ��������: " & Server.HTMLEncode(FileName)

' ����������� ������
Set Upload = Nothing
%>
