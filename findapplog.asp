<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") == 1,
Title = "Події";

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

function WriteEventType() {
	var EventName = ["Завантаження показників", "Завантаження оплат", "Апдейт договору"],
	ResponseText = '<FIELDSET><LEGEND>Подія</LEGEND>\n<SELECT NAME="EventType">',
	option;
	for (var k in EventName) {
		option = ['<OPTION VALUE="', k, '">', EventName[k], '</OPTION>\n'];
		ResponseText += option.join("");
	}
	ResponseText += '</SELECT></FIELDSET>';
	Response.Write(ResponseText)
}

with (Html) {
	SetHead(Title);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindAppLog" ACTION="listapplog.asp" METHOD="post">
<INPUT TYPE="HIDDEN" NAME="EventName">
<H3 CLASS="HeadText"><%=Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<% Html.WriteDatePeriod("Період", Session("OperDate"), Session("EndDate"), Html.MinDate, Html.MaxDate);
	WriteEventType() %>
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn">&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>
