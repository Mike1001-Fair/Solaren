<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/session.inc" -->
<!-- #INCLUDE FILE="Include/serverinfo.inc" -->
<% var Authorized = User.RoleId == 0;
User.ValidateAccess(Authorized, "GET");
Html.SetHead("Сервер", 1);
Menu.Write(0);
ServerInfo.AddObjInfo(SessionInfo);
ServerInfo.AddRequestInfo();
ServerInfo.Text.push('</TABLE></FIELDSET></DIV></BODY></HTML>');
Response.Write(ServerInfo.Text.join("\n"))%>
