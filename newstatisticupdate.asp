<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/new.set" -->
<% var Authorized = User.RoleId == 0;
User.CheckAccess(Authorized, "GET");

try {
	Db.SetCmd("GetBaseInfo");
	var rs = Db.Execute("GetBaseInfo");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}

Html.SetPage("Оновлення статистики")%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="StatisticUpdate" ACTION="runstatisticupdate.asp" METHOD="post">
<H3 CLASS="HeadText"><%=Html.Title%></H3>
<% Config.WriteDbInfo(rs);
Db.Close() %>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn">&#9989;Виконати</BUTTON>
</FORM></BODY></HTML>


