<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/serverinfo.set" -->
<% var Authorized = User.RoleId == 0;
User.CheckAccess(Authorized, "GET");
Html.SetHead("Сервер", 1);
Menu.Write(0);
ServerInfo.Render() %>
