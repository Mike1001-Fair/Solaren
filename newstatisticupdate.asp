<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 0;
User.ValidateAccess(Authorized, "GET");

try {
	Solaren.SetCmd("GetBaseInfo");
	var rs = Solaren.Execute("GetBaseInfo", "Iнформацiю не знайдено");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}

Html.SetPage("Оновлення статистики", User.RoleId)%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="StatisticUpdate" ACTION="runstatisticupdate.asp" METHOD="post">
<H3 CLASS="HeadText"><%=Html.Title%></H3>
<% Html.WriteBaseInfo(rs);
Solaren.Close() %>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn">&#9989;Виконати</BUTTON>
</FORM></BODY></HTML>
