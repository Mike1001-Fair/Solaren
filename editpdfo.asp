<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->

<% var Authorized = User.RoleId == 1,
PdfoId = Request.QueryString("PdfoId");
User.ValidateAccess(Authorized, "GET");

try {
	Solaren.SetCmd("GetPdfo");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("PdfoId", adInteger, adParamInput, 10, PdfoId));
		}
	}
	var rs = Cmd.Execute();
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	with (rs) {
		var BegDate = Fields("BegDate").value,
		EndDate     = Fields("EndDate").value,
		PdfoTax     = Fields("PdfoTax").value,
		Deleted     = Fields("Deleted").value,
		Title       = Deleted ? "Перегляд ставки пдфо" : "Редагування ставки пдфо";
		Close();
	} 
	Solaren.Close();
	Html.SetPage(Title)
}%>

<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditPdfo" ACTION="updatepdfo.asp" METHOD="POST">
<INPUT TYPE="HIDDEN" NAME="PdfoId" VALUE="<%=PdfoId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">

<H3 CLASS="HeadText"><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<% Month.WriteDatePeriod("Період", BegDate, EndDate, Month.Date[0], Month.Date[4]) %>
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<LABEL>Ставка
	<INPUT TYPE="Number" NAME="PdfoTax" VALUE="<%=PdfoTax%>" STEP="0.1" MIN="0" MAX="99" PLACEHOLDER="%" REQUIRED></LABEL>
	</FIELDSET></TD></TR>
</TABLE>
<% Html.WriteEditButton(1)%>
</FORM></BODY></HTML>
