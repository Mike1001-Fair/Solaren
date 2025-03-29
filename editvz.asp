<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->

<% var Authorized = User.RoleId == 1,
VzId = Request.QueryString("VzId");
User.ValidateAccess(Authorized, "GET");

try {
	Solaren.SetCmd("GetVz");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("VzId", adInteger, adParamInput, 10, VzId));
		}
	}
	var rs = Cmd.Execute();
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	with (rs) {
		var BegDate = Fields("BegDate").value,
		EndDate     = Fields("EndDate").value,
		VzTax       = Fields("VzTax").value,
		Deleted     = Fields("Deleted").value,
		Title       = Deleted ? "Перегляд ставки ВЗ" : "Редагування ставки ВЗ";
		Close();
	} 
	Solaren.Close();
	Html.SetPage(Title)
}%>

<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditVz" ACTION="updatevz.asp" METHOD="POST">
<INPUT TYPE="HIDDEN" NAME="VzId" VALUE="<%=VzId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">

<H3 CLASS="HeadText"><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<% Month.WriteDatePeriod("Період", BegDate, EndDate, Month.Date[0], Month.Date[4]) %>
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<LABEL>Ставка
	<INPUT TYPE="Number" NAME="VzTax" VALUE="<%=VzTax%>" STEP="0.1" MIN="0" MAX="99" PLACEHOLDER="%" REQUIRED></LABEL>
	</FIELDSET></TD></TR>
</TABLE>
<% Html.WriteEditButton(1)%>
</FORM></BODY></HTML>
