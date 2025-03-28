<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/json.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 3,
FolderName = Request.QueryString("FolderName"),
JsonResponse = Authorized ? '{"files":' : '{"files":[0]}';

if (Authorized) {
	try {
		//var Fso = Server.CreateObject("Scripting.FileSystemObject"),
		FolderPath = Server.MapPath(FolderName);
		if (Fso.FolderExists(FolderPath)) {			
			var Folder = Fso.GetFolder(FolderPath);
			JsonResponse +=	Json.toString(Folder.Files);
			//JsonResponse = Json.stringify(Folder.Files);
		} else {
			JsonResponse += '[-1]';
		}
		JsonResponse += '}';
	} catch (ex) {
		Message.Write(3, Message.Error(ex));
	}
}

with (Response) {
	CacheControl = "no-cache, no-store, must-revalidate";
	AddHeader("Content-Type","application/json");
	Write(JsonResponse);
}%>
