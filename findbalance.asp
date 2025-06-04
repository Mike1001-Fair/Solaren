<%@LANGUAGE="JavaScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/referer.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = User.RoleId == 1;
User.ValidateAccess(Authorized, "GET")

try {
	Solaren.SetCmd("SelectOperator");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
		}
	}
	var rs = Solaren.Execute("SelectOperator");
} catch (ex) {
	Message.Write(3, Message.Error(ex))	
}

Html.SetPage("Баланс")%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindBalance" ACTION="listbalance.asp" METHOD="post" TARGET="_blank">
<INPUT TYPE="HIDDEN" NAME="OperatorName">
<H3 CLASS="HeadText"><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<% Month.WritePeriod() %>
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<LABEL FOR="OperatorId">Оператор</LABEL>
	<% Html.WriteSelect(rs, "Operator", 0, -1);
	Solaren.Close(); %>
	</FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn">&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>



