<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") == 1,
Title = "Події",
Event = {
	Name: ["Завантаження показників", "Завантаження оплат", "Апдейт договору"],
	Write: function() {
		var ResponseText = '<FIELDSET><LEGEND>Подія</LEGEND>\n<SELECT NAME="EventType">',
		option;
		for (var i = 0; i < this.Name.length; i++) {
			option = ['<OPTION VALUE="', i, '">', this.Name[i], '</OPTION>\n'];
			ResponseText += option.join("");
		}
		ResponseText += '</SELECT></FIELDSET>';
		Response.Write(ResponseText)
	}
};

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Html) {
	SetHead(Title);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindAppLog" ACTION="listapplog.asp" METHOD="post">
<INPUT TYPE="HIDDEN" NAME="EventName">
<H3 CLASS="HeadText"><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<% Html.WriteDatePeriod("Період", Html.Date[1], Html.Date[2], Html.Date[0], Html.Date[2]);
	Event.Write()%>
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn">&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>
