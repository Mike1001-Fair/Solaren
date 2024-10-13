<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") == 0;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

try {
	Solaren.SetCmd("GetBaseInfo");
	var rs = Solaren.Execute("GetBaseInfo", "Iнформацiю не знайдено");
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

with (Html) {
	SetHead("Резервна копія");
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="BackupBase" ACTION="runbackupbase.asp" METHOD="post">
<H3 CLASS="HeadText">Резервна копія</H3>
<% Html.WriteBaseInfo(rs);
Connect.Close() %>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn">&#9989;Створити</BUTTON>
</FORM></BODY></HTML>
