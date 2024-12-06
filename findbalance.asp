<%@LANGUAGE="JavaScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1,
Title = "Баланс";
User.ValidateAccess(Authorized, "GET")

try {
	Solaren.SetCmd("SelectOperator");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
		}
	}
	var rs = Solaren.Execute("SelectOperator", "Iнформацiю не знайдено");
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))	
}

Html.SetPage(Title, User.RoleId)%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindBalance" ACTION="listbalance.asp" METHOD="post" TARGET="_blank">
<INPUT TYPE="HIDDEN" NAME="OperatorName">
<H3 CLASS="HeadText"><%=Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<% Html.WriteMonthPeriod() %>
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<LABEL FOR="OperatorId">Оператор</LABEL>
	<% Html.WriteSelect(rs, "Operator", 0, -1);
	Connect.Close(); %>
	</FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn">&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>
