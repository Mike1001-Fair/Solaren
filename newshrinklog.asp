<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Include/new.inc" -->
<% var Authorized = User.RoleId == 0;
User.CheckAccess(Authorized, "GET");

try {
	Solaren.SetCmd("GetBaseInfo");
	var rs = Solaren.Execute("GetBaseInfo");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}

Html.SetPage("Обрізка логу")%>

<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="ShrinkLog" ACTION="runshrinklog.asp" METHOD="post">
<H3 CLASS="HeadText"><%=Html.Title%></H3>
<% Config.WriteDbInfo(rs);
Solaren.Close() %>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn">&#9989;Виконати</BUTTON>
</FORM></BODY></HTML>


