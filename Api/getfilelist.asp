<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/api.set" -->
<% var Authorized = User.RoleId == 1,
Query = Webserver.Parse(),
ValidRequest = User.HasAccess(Authorized, "GET");

if (ValidRequest) {
	try {
		var result = ['{"files":'],
		FolderPath = Server.MapPath("..") + Query.FolderName;
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
