<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = User.RoleId == 1,
Event = {
	Name: ["Завантаження показників", "Завантаження оплат", "Апдейт договору"],
	Write: function() {
		var ResponseText = ['<FIELDSET><LEGEND>Подія</LEGEND>',
			'<SELECT NAME="EventType">'
		],
		option;
		for (var i = 0; i < this.Name.length; i++) {
			option = ['<OPTION VALUE="', i, '">', this.Name[i], '</OPTION>'];
			ResponseText.push(option.join(""));
		}
		ResponseText.push('</SELECT></FIELDSET>');
		Response.Write(ResponseText.join("\n"))
	}
};

if (User.ValidateAccess(Authorized, "GET")) {
	Html.SetPage("Події")
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindAppLog" ACTION="listapplog.asp" METHOD="post">
<INPUT TYPE="HIDDEN" NAME="EventName">
<H3 CLASS="HeadText"><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<% Month.WriteDatePeriod("Період", Month.Date[1], Month.Date[2], Month.Date[0], Month.Date[2]);
	Event.Write()%>
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn">&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>


