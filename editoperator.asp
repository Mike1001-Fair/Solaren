<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1,
OperatorId = Request.QueryString("OperatorId");
User.ValidateAccess(Authorized, "GET");

try {
	Solaren.SetCmd("GetOperator");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("OperatorId", adInteger, adParamInput, 10, OperatorId));
		}
	}
	var rsOperator = Solaren.Execute("GetOperator");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	with (rsOperator) {
		var SortCode = Fields("SortCode").value,
		EdrpoCode    = Fields("EdrpoCode").value,
		OperatorName = Fields("OperatorName").value,
		Deleted      = Fields("Deleted").value,
		Title        = Deleted ? "Перегляд анкети" : "Редагування анкети";
		Close();
	}
	Solaren.Close();
	Html.SetPage(Title)
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditOperator" ACTION="updateoperator.asp" METHOD="POST" AUTOCOMPLETE="off">
<INPUT TYPE="HIDDEN" NAME="OperatorId" VALUE="<%=OperatorId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">

<H3 CLASS="HeadText"><IMG SRC="Images/OperatorIcon.svg"><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<FIELDSET NAME="OperatorSet"><LEGEND>Параметри</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">№</TD>
	<TD><INPUT TYPE="Number" NAME="SortCode" VALUE="<%=SortCode%>" MIN="1" MAX="99" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Код</TD>
	<TD><INPUT TYPE="TEXT" NAME="EdrpoCode" PLACEHOLDER="ЄДРПОУ" VALUE="<%=EdrpoCode%>" SIZE="9" MAXLENGTH="8" PATTERN="\d{8}" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Назва</TD>
	<TD><INPUT TYPE="TEXT" NAME="OperatorName" PLACEHOLDER="Коротка без лапок" VALUE="<%=OperatorName%>" SIZE="30" MAXLENGTH="30" REQUIRED></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<% Html.WriteEditButton(1)%>
</FORM></BODY></HTML>


