<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->

<% var Authorized = User.RoleId == 1;
User.ValidateAccess(Authorized, "GET")

try {
	Solaren.SetCmd("SelectChief");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
		}
	}
	var rs = Solaren.Execute("SelectChief", "Довiдник керiвникiв пустий");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}

Html.SetPage("Бюджетний код", User.RoleId)%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindBudgetCode" TARGET="_blank" ACTION="prnbudgetcode.asp" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="HIDDEN" NAME="ChiefName">
<H3 CLASS="HeadText"><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET><LEGEND ALIGN="CENTER">Параметри</LEGEND>
	<LABEL>Керівник	<%Html.WriteSelect(rs, "Chief", 0, -1)%></LABEL>
	</FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn">&#128270;Пошук</BUTTON></FORM></BODY></HTML>
