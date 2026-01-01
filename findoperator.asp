<%@ LANGUAGE="JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Include/find.inc" -->
<% var Authorized = User.RoleId == 1;
if (User.CheckAccess(Authorized, "GET")) {
	Html.SetPage("Оператори")
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindOperator" ACTION="listoperator.asp" METHOD="post" AUTOCOMPLETE="off">
<H3 CLASS="HeadText"><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<FIELDSET><LEGEND>Назва</LEGEND>
	<INPUT TYPE="search" NAME="OperatorName" SIZE="20" maxLength="10" REQUIRED AUTOFOCUS>
	</FIELDSET>
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>



