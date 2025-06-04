<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/referer.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/json.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
FolderName = Request.QueryString("FolderName");

if (Authorized) {
	try {
		var result = ['{"files":'],
		FolderPath = Server.MapPath(FolderName);
		if (Fso.FolderExists(FolderPath)) {			
			var Folder = Fso.GetFolder(FolderPath),
			list = Json.toString(Folder.Files);
			result.push(list);
		} else {
			result.push('[-1]');
		}
		result.push('}');
		Json.data =	result.join("");
	} catch (ex) {
		Message.Write(3, Message.Error(ex));
	}
} else {
	Json.data = '{"files":[0]}';
}
Json.write()%>
