<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/find.set" -->
<% var Authorized = User.RoleId == 1,
Event = {
	Name: ["Завантаження показників", "Завантаження оплат", "Апдейт договору"],
	Write: function() {
		var Output = ['<FIELDSET><LEGEND>Подія</LEGEND>',
			'<SELECT NAME="EventType">'
		];
		for (var i = 0; i < this.Name.length; i++) {
			var option = ['<OPTION VALUE="', i, '">', this.Name[i], '</OPTION>'];
			Output.push(option.join(""));
		}
		Output.push('</SELECT></FIELDSET>');
		Response.Write(Output.join("\n"))
	}
};

if (User.CheckAccess(Authorized, "GET")) {
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


