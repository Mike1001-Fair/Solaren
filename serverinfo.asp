<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/serverinfo.set" -->
<% var Authorized = User.RoleId == 0;
if (User.CheckAccess(Authorized, "GET")) {
	var Output = ServerInfo.Render();
	Html.SetHead("Сервер", 1);
	Menu.Write(0);
	Response.Write(Output)
}%>
